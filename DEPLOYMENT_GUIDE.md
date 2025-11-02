# 🚀 Руководство по развертыванию документации

## ✅ Навигация настроена!

Файл `src/SUMMARY.md` теперь содержит стандартную структуру для mdBook с полной навигацией:

```
Содержание
├── Введение
│
├── Лабораторные работы
│   └── Лабораторная работа №1: Система контроля СИЗ
│       ├── Введение
│       ├── Задачи системы
│       ├── Целевая аудитория и области применения
│       ├── Технологический стэк
│       ├── Требования системы контроля СИЗ
│       ├── Архитектура нейронной сети
│       ├── Сравнение с альтернативными архитектурами
│       ├── Реализация пользовательского интерфейса
│       ├── Показатели эффективности обученной модели
│       ├── Заключение
│       └── Источники
│
├── Приложения
│   └── Диаграммы и графики
│
└── Справка
    ├── Конфигурация проекта
    └── Настройка и запуск
```

---

## 🔨 Сборка документации

### Локально

```bash
cd ~/system-engineering-playbook

# Собрать книгу
mdbook build

# Или собрать и запустить локальный сервер
mdbook serve --open
```

Документация откроется в браузере: **http://localhost:3000**

---

## 📤 Публикация на GitHub Pages

### Шаг 1: Закоммитьте изменения

```bash
cd ~/system-engineering-playbook

# Добавить все изменения
git add .

# Создать коммит
git commit -m "Update documentation: add navigation and diagrams"
```

### Шаг 2: Push в GitHub

```bash
git push origin main
```

### Шаг 3: Настройка GitHub Pages

1. Перейдите в ваш репозиторий на GitHub
2. Откройте **Settings** → **Pages**
3. Выберите:
   - **Source**: Deploy from a branch
   - **Branch**: `main`
   - **Folder**: `/book` или `/docs` (если переименовали)
4. Нажмите **Save**

GitHub Pages автоматически опубликует вашу документацию.

---

## 🤖 Автоматическая публикация (рекомендуется)

Создайте файл `.github/workflows/deploy.yml`:

```yaml
name: Deploy Documentation

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v3

      - name: Setup mdBook
        uses: peaceiris/actions-mdbook@v1
        with:
          mdbook-version: 'latest'

      - name: Build book
        run: mdbook build

      - name: Deploy to GitHub Pages
        if: github.ref == 'refs/heads/main'
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./book
          force_orphan: true
```

После этого:
1. Коммитите изменения
2. Push в GitHub
3. GitHub Actions автоматически соберет и опубликует документацию
4. В Settings → Pages выберите ветку `gh-pages`

---

## 📋 Быстрые команды

```bash
# Сборка
mdbook build

# Локальный просмотр с автообновлением
mdbook serve --open

# Очистка и пересборка
mdbook clean && mdbook build

# Тестирование
mdbook test

# Запуск скрипта развертывания
./deploy.sh
```

---

## 📁 Структура файлов

```
system-engineering-playbook/
├── src/
│   ├── SUMMARY.md              ⭐ Навигация (обновлена)
│   ├── README.md               📝 Главная страница
│   ├── lab1-mask-detection.md  📚 Лаб. работа №1
│   ├── attachments.md          📊 Приложения
│   ├── SETUP.md                ⚙️ Настройка
│   ├── md.md                   📄 Конфигурация
│   └── assets/
│       └── lab1/               🎨 Диаграммы (6 файлов)
│           ├── architecture_diagram.png
│           ├── training_performance.png
│           ├── confusion_matrix.png
│           ├── architecture_comparison.png
│           ├── system_workflow.png
│           └── metrics_dashboard.png
│
├── book/                       🌐 Сгенерированный сайт
│   ├── index.html
│   ├── lab1-mask-detection.html
│   └── ...
│
├── book.toml                   📋 Конфигурация mdBook
├── deploy.sh                   🚀 Скрипт развертывания
└── .github/
    └── workflows/
        └── deploy.yml          🤖 GitHub Actions (опционально)
```

---

## ✅ Проверочный список

Перед публикацией убедитесь:

- [x] `src/SUMMARY.md` содержит правильную структуру навигации
- [x] Все файлы существуют:
  - [x] `src/README.md`
  - [x] `src/lab1-mask-detection.md`
  - [x] `src/attachments.md`
  - [x] `src/SETUP.md`
  - [x] `src/md.md`
- [x] Все 6 диаграмм в `src/assets/lab1/`
- [x] `mdbook build` выполняется без ошибок
- [x] Локальный просмотр работает (`mdbook serve`)

---

## 🐛 Решение проблем

### Проблема: "Навигация не отображается"

**Решение:**
```bash
# Убедитесь, что используется правильный формат SUMMARY.md
cat src/SUMMARY.md

# Пересоберите книгу
mdbook clean && mdbook build
```

### Проблема: "Изображения не загружаются"

**Решение:**
```bash
# Проверьте, что изображения на месте
ls -la src/assets/lab1/

# Проверьте пути в файлах (должны быть относительные)
# Правильно: ![](assets/lab1/diagram.png)
# Неправильно: ![](/assets/lab1/diagram.png)
```

### Проблема: "GitHub Pages показывает 404"

**Решение:**
1. Убедитесь, что в Settings → Pages выбрана правильная ветка и папка
2. Проверьте наличие файла `.nojekyll` в папке `book/`
3. Подождите несколько минут после push (GitHub Pages обновляется не сразу)

---

## 🎯 Следующие шаги

1. ✅ Навигация настроена
2. ✅ Диаграммы созданы
3. ✅ Источники проверены
4. ⏭️ Закоммитьте изменения
5. ⏭️ Push в GitHub
6. ⏭️ Настройте GitHub Pages
7. ⏭️ Проверьте результат на вашем GitHub Pages URL

---

## 📞 Дополнительная информация

- 📖 [Документация mdBook](https://rust-lang.github.io/mdBook/)
- 🐙 [GitHub Pages документация](https://docs.github.com/en/pages)
- 🎨 [Примеры mdBook проектов](https://github.com/topics/mdbook)

---

**Готово к публикации! 🎉**
