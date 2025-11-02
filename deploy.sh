#!/bin/bash

echo "=========================================="
echo "📚 Сборка и публикация документации"
echo "=========================================="
echo ""

# Build the book
echo "🔨 Сборка mdBook..."
mdbook build

if [ $? -eq 0 ]; then
    echo "✅ Сборка завершена успешно!"
    echo ""
    echo "📁 Файлы находятся в папке: ./book/"
    echo ""
    echo "Следующие шаги:"
    echo "1. Закоммитьте изменения: git add . && git commit -m 'Update documentation'"
    echo "2. Push в GitHub: git push origin main"
    echo "3. GitHub Pages автоматически обновится"
    echo ""
    echo "Для локального просмотра выполните: mdbook serve --open"
else
    echo "❌ Ошибка при сборке!"
    exit 1
fi

echo "=========================================="
