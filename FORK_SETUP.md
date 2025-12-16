# Настройка форка 3x-ui для собственных релизов

Это руководство поможет вам настроить форк оригинального репозитория 3x-ui для создания собственных релизов с вашими доработками.

## Предварительные требования

1. GitHub аккаунт
2. Форк репозитория [MHSanaei/3x-ui](https://github.com/MHSanaei/3x-ui)
3. Локальный клон вашего форка

## Шаг 1: Настройка удаленных репозиториев

Добавьте оригинальный репозиторий как upstream:

```bash
git remote add upstream https://github.com/MHSanaei/3x-ui.git
git remote -v
```

Вы должны увидеть:
- `origin` - ваш форк
- `upstream` - оригинальный репозиторий

## Шаг 2: Обновление скриптов для вашего репозитория

Все скрипты (`install.sh`, `update.sh`, `x-ui.sh`) были обновлены для поддержки переменной окружения `GITHUB_REPO`. 

По умолчанию используется оригинальный репозиторий `MHSanaei/3x-ui`, но вы можете переопределить его:

```bash
export GITHUB_REPO="ваш-username/ваш-репозиторий"
bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/install.sh)
```

## Шаг 3: Создание релизов

### Автоматическая сборка через GitHub Actions

1. Убедитесь, что файл `.github/workflows/release.yml` существует
2. Создайте новый релиз на GitHub:
   - Перейдите в раздел Releases
   - Нажмите "Draft a new release"
   - Создайте тег в формате `vX.Y.Z` (например, `v2.8.6`)
   - Заполните описание релиза
   - Нажмите "Publish release"

GitHub Actions автоматически соберет бинарники для всех платформ и прикрепит их к релизу.

### Ручная сборка

Если вы хотите собрать вручную:

```bash
# Для Linux
GOOS=linux GOARCH=amd64 go build -ldflags "-w -s" -o x-ui main.go

# Для Windows
GOOS=windows GOARCH=amd64 go build -ldflags "-w -s" -o x-ui.exe main.go
```

## Шаг 4: Слияние изменений из оригинального репозитория

Используйте скрипт `merge-upstream.sh` для автоматического слияния:

```bash
bash merge-upstream.sh
```

Или выполните вручную:

```bash
# Получить последние изменения из upstream
git fetch upstream

# Переключиться на вашу основную ветку
git checkout main

# Слить изменения из upstream
git merge upstream/main

# Разрешить конфликты, если они есть
# Затем закоммитить и запушить
git push origin main
```

## Шаг 5: Установка вашей версии

После создания релиза, пользователи могут установить вашу версию:

```bash
# Установка последней версии
export GITHUB_REPO="ваш-username/ваш-репозиторий"
bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/install.sh)

# Или напрямую указать в команде
GITHUB_REPO="ваш-username/ваш-репозиторий" bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/install.sh)
```

## Шаг 6: Обновление существующей установки

Для обновления существующей установки до вашей версии:

```bash
export GITHUB_REPO="ваш-username/ваш-репозиторий"
bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/update.sh)
```

## Рекомендации

1. **Версионирование**: Используйте семантическое версионирование (SemVer)
   - Формат: `vMAJOR.MINOR.PATCH`
   - Пример: `v2.8.6`

2. **Ветвление**: Создавайте отдельные ветки для каждой функции или исправления
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Коммиты**: Делайте понятные коммиты с описанием изменений
   ```bash
   git commit -m "feat: добавлена поддержка параметра SpiserX"
   ```

4. **Тестирование**: Тестируйте изменения перед созданием релиза

5. **Документация**: Обновляйте README.md с описанием ваших изменений

## Структура релиза

Каждый релиз должен содержать:
- `x-ui-linux-amd64.tar.gz`
- `x-ui-linux-arm64.tar.gz`
- `x-ui-linux-armv7.tar.gz`
- `x-ui-linux-armv6.tar.gz`
- `x-ui-linux-armv5.tar.gz`
- `x-ui-linux-386.tar.gz`
- `x-ui-linux-s390x.tar.gz`
- `x-ui-windows-amd64.zip`

Все эти файлы автоматически создаются GitHub Actions при создании релиза.

## Troubleshooting

### Конфликты при слиянии

Если возникают конфликты при слиянии:

```bash
# Посмотреть конфликтующие файлы
git status

# Разрешить конфликты вручную
# Затем:
git add .
git commit -m "Merge upstream changes"
```

### Проблемы с GitHub Actions

Убедитесь, что:
- Файл `.github/workflows/release.yml` существует
- Тег создан в правильном формате (`vX.Y.Z`)
- У вас есть права на создание релизов в репозитории

