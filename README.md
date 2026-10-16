# AERA Recovery — Device Tree для Motorola Edge 50 Fusion (`cuscoi`)

[![AERA Recovery](https://img.shields.io/badge/Recovery-AERA--R1.0-blue.svg)](https://github.com/AERA-Recovery)
[![Platform](https://img.shields.io/badge/Platform-Qualcomm%20SM7435--AB%20(Parrot)-orange.svg)](https://www.qualcomm.com/)
[![Android Version](https://img.shields.io/badge/AOSP-16.0%20(aera--16.0)-green.svg)](https://android.googlesource.com/)

Готовий «напівфабрикат» (готове дерево пристрою / device tree skeleton) для збірки кастомного рекавері **AERA Recovery** (Android 16 / LVGL UI Engine / modern recovery stack) на базі вихідних кодів AERA Recovery та TWRP конфігурацій для **Motorola Edge 50 Fusion** (кодова назва: `cuscoi`).

---

## 📱 Характеристики пристрою (Device Specifications)

| Параметр | Значення |
| :--- | :--- |
| **Пристрій** | Motorola Edge 50 Fusion |
| **Кодова назва** | `cuscoi` / `cuscoi_g` |
| **Моделі** | XT2429-1, XT2429-2, XT2429-3, XT2429-4 |
| **Процесор (SoC)** | Qualcomm Snapdragon 7s Gen 2 (SM7435-AB / `parrot`) |
| **Архітектура** | ARM64 (armv8-2a-dotprod), 64-bit only |
| **Дисплей** | 1080 x 2400 (pOLED, 120Hz/144Hz, виріз під камеру) |
| **Схема розділів** | Virtual A/B (VAB) + Retrofit Dynamic Partitions + Виділений розділ `recovery` |
| **Шифрування Data** | FBEv2 (fileencryption=aes-256-xts with wrappedkey_v0) + Keymint/Gatekeeper AIDL |
| **Файлові системи** | EROFS (system/vendor), F2FS (data/metadata), EXT4 |

---

## 🗂 Структура репозиторію

```text
├── aera_cuscoi.mk              # Головний конфіг AERA: екран, відступи, анімація, бекапи, fs-інструменти
├── twrp_cuscoi.mk              # Базовий Product Makefile для збірки
├── AndroidProducts.mk          # Точки входу lunch (twrp_cuscoi-eng)
├── BoardConfig.mk              # Налаштування плати, ядра, розділів, AVB та шифрування
├── device.mk                   # Підключення HAL, бібліотек дешифрування, сервісів
├── vendorsetup.sh              # Скрипт оточення AERA (змінні, бінарники tar/sed/lz4/zstd/erofs)
├── system.prop                 # Системні властивості середовища рекавері
├── board-info.txt              # Перевірка сумісності плати при прошивці
├── prebuilt/                   # Попередньо скомпільовані бінарники:
│   ├── kernel                  # Ядро GKI під платформу parrot
│   └── dtb.img                 # Device Tree Blob під екран та плату cuscoi
├── recovery/root/              # Ramdisk відновлення:
│   ├── init.recovery.qcom.rc   # Запуск сервісів QCOM, модулів та підсистеми зарядки
│   ├── init.recovery.usb.rc    # Налаштування USB (ADB, MTP, Fastboot)
│   ├── system/bin/             # Сервіси Keymint, Keymaster, Gatekeeper, QSEECom, runatboot
│   ├── system/etc/             # recovery.fstab, twrp.flags, vintf manifest
│   ├── vendor/lib64/           # Бібліотеки для роботи апаратного дешифрування
│   └── vendor_dlkm/            # 260+ модулів ядра (touchscreen, дисплей, аудіо, haptics)
├── security/                   # Сертифікати OTA
├── local_manifests/            # Локальний маніфест для швидкої синхронізації з repo
└── .github/workflows/          # Автоматична збірка через GitHub Actions
    └── build-aera.yml
```

---

## 🛠 Спосіб 1: Локальна збірка (Local Build via repo)

### 1. Вимоги до системи
- Дистрибутив Linux: **Ubuntu 22.04 LTS** (або 20.04 / 24.04 / WSL2)
- Мінімум 16 ГБ оперативної пам'яті (RAM) та 32 ГБ Swap
- Мінімум 100-150 ГБ вільного місця на SSD

### 2. Встановлення залежностей
```bash
sudo apt-get update
sudo apt-get install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
    gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
    libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig \
    libncurses5 python3 rsync lz4 zstd ccache bc libssl-dev

# Встановлення утиліти repo
mkdir -p ~/.bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo
export PATH="$HOME/.bin:$PATH"
```

### 3. Ініціалізація вихідників AERA Recovery (aera-16.0)
```bash
mkdir -p ~/aera_recovery
cd ~/aera_recovery

# Ініціалізація офіційного маніфесту AERA Android 16.0
repo init -u https://github.com/AERA-Recovery/android_manifest.git -b aera-16.0 --depth=1

# Синхронізація (може зайняти від 15 до 45 хвилин залежно від інтернету)
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
```

### 4. Додавання дерева пристрою cuscoi
Скопіюйте цей репозиторій у шлях `device/motorola/cuscoi`:
```bash
mkdir -p ~/aera_recovery/device/motorola/cuscoi
cp -r /path/to/AERA-recovery-cuscoi/* ~/aera_recovery/device/motorola/cuscoi/
```

### 5. Запуск збірки
```bash
cd ~/aera_recovery
source build/envsetup.sh

# Виберіть ціль для Motorola Edge 50 Fusion (Android 16 bp2a):
lunch twrp_cuscoi-bp2a-eng

# Компіляція образу рекавері:
mka adbd recoveryimage -j$(nproc --all)
```

Готовий образ буде розташований за шляхом:
```text
out/target/product/cuscoi/recovery.img
```

---

## ☁️ Спосіб 2: Збірка через GitHub Actions (1-клік без локального Linux)

У репозиторій вже інтегровано готовий робочий процес [`.github/workflows/build-aera.yml`](.github/workflows/build-aera.yml).

1. Створіть новий репозиторій на GitHub (наприклад, `android_device_motorola_cuscoi-AERA`).
2. Запушіть цей вміст у свій репозиторій:
   ```bash
   git init
   git add .
   git commit -m "cuscoi: Initial AERA Recovery tree bringup"
   git branch -M main
   git remote add origin https://github.com/<ваш-нік>/<ваш-репозиторій>.git
   git push -u origin main
   ```
3. Відкрийте вкладку **Actions** у вашому репозиторії на GitHub.
4. Виберіть воркфлоу **"Build AERA Recovery for Motorola Edge 50 Fusion (cuscoi)"**.
5. Натисніть кнопку **"Run workflow"** ➔ Виберіть `recoveryimage` ➔ **Run**.
6. По завершенню збірки з розділу **Artifacts** завантажте готовий `AERA-R1.0-cuscoi-recovery.img`.

---

## ⚡️ Прошивка та запуск на телефоні (Flashing & Booting)

> [!WARNING]
> Для прошивки кастомного рекавері завантажувач (Bootloader) вашого пристрою має бути офіційно розблокований!

### Тестовий запуск без зміни системи (Fastboot Boot):
```bash
adb reboot bootloader
fastboot boot recovery.img
```

### Повна прошивка у розділ Recovery:
Оскільки Motorola Edge 50 Fusion має виділений розділ recovery для кожного слоту (A/B):
```bash
adb reboot bootloader
fastboot flash recovery recovery.img
fastboot reboot recovery
```

Якщо використовується збірка через `boot`:
```bash
fastboot flash boot boot.img
fastboot reboot recovery
```

---

## ⚙️ Особливості та тюнінг конфігурацій

- **Адаптивна роздільна здатність AERA (Adaptive Resolution):**
  Увімкнено `AERA_UI2_ADAPTIVE_RESOLUTION := true` та віртуальне полотно `2400x1080` з частотою оновлення `120Hz`.
- **Виріз камери (Notch):**
  Відступ статус-бару становить `94px` (`AERA_STATUS_H := 94`) з приховуванням вирізу (`AERA_HIDE_NOTCH := 1`).
- **Ядро та драйвери:**
  Використовується стабільне GKI ядро `prebuilt/kernel` з повним комплектом з 260+ вендорних модулів (`focaltech`, `goodix`, `ili9882`, `leds`, `sound`, `charging`).
- **FBEv2 Дешифрування:**
  Підключено вендорні блоби Keymint v1 / Gatekeeper AIDL, що дозволяє AERA коректно розшифровувати розділ `/data` на Android 14/15/16.

---

## 📜 Ліцензія та подяки

- **AERA Recovery Project** — https://github.com/AERA-Recovery
- **TeamWin Recovery Project (TWRP)**
- **OrangeFox Recovery Project**
- **LineageOS Project & Motorola-Parrot Team**
