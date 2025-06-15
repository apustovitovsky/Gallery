# Gallery

Gallery — это приложение для просмотра фотографий, использующее API Unsplash.

- Просмотр галереи фотографий.
- Детальный просмотр изображения.
- Поддержка различных ориентаций экрана.

<img src="Documentation/gallery.png" alt="Gallery" style="max-width: 100%; max-height: 400px; height: auto;">

## Требования

- iOS 18.0 или выше.
- Xcode 16.4 или выше.

## ❗️ API-ключ

Файл с API-ключом находится в `.gitignore`, поэтому перед запуском приложения необходимо создать файл `Gallery/Resources/Secrets.xcconfig` и указать в нем ваш API ключ Unsplash:

```plaintext
UNSPLASH_API_KEY=ваш_ключ
```

## Структура проекта

- `Gallery/Resources/` — ресурсы приложения, включая файлы конфигурации и локализации.
- `Gallery/Screens/` — экраны приложения, включая галерею и детальный просмотр.
- `Gallery/PhotoRepository/` — репозиторий для работы с API Unsplash.
