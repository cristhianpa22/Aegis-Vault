# Aegis Vault

Aplicación Flutter para gestionar safehouses (casas seguras). Se conecta a Supabase para consultar y administrar la información almacenada en la base de datos.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart ^3.12.0)
- Cuenta y proyecto en [Supabase](https://supabase.com)

## Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/cristhianpa22/Aegis-Vault.git
cd Aegis-Vault
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Configura las variables de entorno. Copia el archivo de ejemplo y completa tus credenciales de Supabase:

```bash
cp lib/.env.example lib/.env
```

Edita `lib/.env` con tu URL y tu clave **anon** (public):

```env
supabaseUrl=https://tu-proyecto.supabase.co
apiKey=tu_clave_anon
```

4. Ejecuta la aplicación:

```bash
flutter run
```
