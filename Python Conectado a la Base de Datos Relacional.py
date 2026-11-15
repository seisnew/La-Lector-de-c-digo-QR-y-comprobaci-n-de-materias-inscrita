import json
import sqlite3
import qrcode

# Nombre del archivo de base de datos que creamos
DB_NAME = "unefa_telecomunicaciones.db"


def conectar_db():
  return sqlite3.connect(DB_NAME)


# --- 1. FUNCIÓN PARA OBTENER MATERIAS DISPONIBLES DESDE LA BD ---
def obtener_materias_disponibles(cedula_estudiante: str):
  conn = conectar_db()
  cursor = conn.cursor()

  # Obtener códigos de materias ya aprobadas por el estudiante
  cursor.execute(
      "SELECT materia_codigo FROM historial_estudiantes WHERE cedula = ? AND"
      " estatus = 'APROBADA'",
      (cedula_estudiante,),
  )
  aprobadas = [row[0] for row in cursor.fetchall()]

  # Obtener todo el pensum
  cursor.execute("SELECT codigo, nombre, semestre, uc FROM materias")
  todas_materias = cursor.fetchall()

  disponibles = []
  for codigo, nombre, semestre, uc in todas_materias:
    if codigo in aprobadas:
      continue  # Si ya la aprobó, no se puede inscribir

    # Buscar prelaciones requeridas para esta materia en la BD
    cursor.execute(
        "SELECT requisito_codigo FROM prelaciones WHERE materia_codigo = ?",
        (codigo,),
    )
    requisitos = [row[0] for row in cursor.fetchall()]

    # Verificar si el estudiante cumple con todas las prelaciones
    cumple_prelaciones = all(req in aprobadas for req in requisitos)

    if cumple_prelaciones or not requisitos:
      disponibles.append({
          "codigo": codigo,
          "nombre": nombre,
          "semestre": semestre,
          "uc": uc,
      })

  conn.close()
  return disponibles


# --- 2. FUNCIÓN DE VALIDACIÓN DEL QR USANDO LA BD ---
def validar_qr_desde_db(datos_qr_json: str):
  data = json.loads(datos_qr_json)
  cedula = data.get("cedula")
  materias_inscritas = data.get("materias", [])

  conn = conectar_db()
  cursor = conn.cursor()

  # Obtener historial de aprobadas del estudiante
  cursor.execute(
      "SELECT materia_codigo FROM historial_estudiantes WHERE cedula = ? AND"
      " estatus = 'APROBADA'",
      (cedula,),
  )
  aprobadas = [row[0] for row in cursor.fetchall()]

  errores = []
  semestres = []

  for codigo in materias_inscritas:
    # Verificar que la materia exista y traer su info
    cursor.execute(
        "SELECT nombre, semestre FROM materias WHERE codigo = ?", (codigo,)
    )
    materia_info = cursor.fetchone()

    if not materia_info:
      errores.append(
          f"El código '{codigo}' no se encuentra registrado en el pensum."
      )
      continue

    nombre, semestre = materia_info
    semestres.append(semestre)

    # 1. Validar prelaciones desde la BD
    cursor.execute(
        "SELECT requisito_codigo FROM prelaciones WHERE materia_codigo = ?",
        (codigo,),
    )
    requisitos = [row[0] for row in cursor.fetchall()]
    for req in requisitos:
      if req not in aprobadas:
        cursor.execute("SELECT nombre FROM materias WHERE codigo = ?", (req,))
        req_nombre = cursor.fetchone()[0]
        errores.append(
            f"Prelación incumplida: Para inscribir '{nombre}' necesitas tener"
            f" aprobada '{req_nombre}'."
        )

    # 2. Validar correquisitos desde la BD (materias que deben verse juntas)
    cursor.execute(
        "SELECT materia_b FROM correquisitos WHERE materia_a = ?", (codigo,)
    )
    correqs = [row[0] for row in cursor.fetchall()]
    for cor in correqs:
      if cor not in materias_inscritas and cor not in aprobadas:
        cursor.execute("SELECT nombre FROM materias WHERE codigo = ?", (cor,))
        cor_nombre = cursor.fetchone()[0]
        errores.append(
            f"Correquisito faltante: Al inscribir '{nombre}' debes ver en"
            f" simultáneo '{cor_nombre}'."
        )

  # 3. Validar adyacencia de semestres (máximo 1 de diferencia entre la menor y mayor)
  if semestres and (max(semestres) - min(semestres) > 1):
    errores.append(
        f"Inconsistencia de semestres: Estás mezclando materias del semestre"
        f" {min(semestres)} con el semestre {max(semestres)} (Salto de semestres"
        " no permitido)."
    )

  conn.close()

  if errores:
    return {"estado": "MAL INSCRITO ❌", "detalles": errores}
  return {
      "estado": "BIEN INSCRITO ✅",
      "detalles": ["La inscripción cumple perfectamente con todas las reglas."],
  }
