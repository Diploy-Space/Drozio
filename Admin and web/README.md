# Drozio — Admin Panel & Web Engine

The central backend engine and web frontend for the Drozio multi-vendor marketplace, built on Laravel.

---

## 🛠 Tech Stack
- **Framework:** Laravel 11 / 12
- **Language:** PHP 8.2+
- **Database:** MySQL 8.0+ or MariaDB 10.4+
- **Frontend:** Blade, TailwindCSS / Bootstrap, Alpine.js / jQuery
- **API Standard:** RESTful JSON (v6 API contracts)

---

## ⚙️ System Requirements
- PHP `>= 8.2`
- Required PHP Extensions: `BCMath`, `Ctype`, `cURL`, `DOM`, `Fileinfo`, `JSON`, `Mbstring`, `OpenSSL`, `PCRE`, `PDO`, `Tokenizer`, `XML`, `GD`
- Composer `>= 2.5`
- MySQL `>= 8.0`

---

## 🚀 Installation & Local Development

1. **Install Composer Dependencies:**
   ```bash
   composer install --no-dev --optimize-autoloader
   ```

2. **Environment Configuration:**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```
   Configure database and mail settings in `.env`:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=drozio_db
   DB_USERNAME=root
   DB_PASSWORD=your_password
   ```

3. **Database Migrations & Seeders:**
   ```bash
   php artisan migrate --seed
   ```

4. **Storage Symlink:**
   ```bash
   php artisan storage:link
   ```

5. **Optimization:**
   ```bash
   php artisan optimize:clear
   php artisan config:cache
   php artisan route:cache
   php artisan view:cache
   ```

6. **Serve Locally:**
   ```bash
   php artisan serve
   ```
