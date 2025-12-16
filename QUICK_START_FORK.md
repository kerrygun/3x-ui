# Быстрый старт для форка 3x-ui

## Что было сделано

Все скрипты обновлены для поддержки переменной окружения `GITHUB_REPO`, что позволяет использовать любой форк репозитория.

## Как использовать

### 1. Настройка upstream репозитория

```bash
git remote add upstream https://github.com/MHSanaei/3x-ui.git
```

### 2. Слияние изменений из оригинального репозитория

```bash
bash merge-upstream.sh
```

Или вручную:

```bash
git fetch upstream
git merge upstream/main
```

### 3. Создание релиза

1. Создайте тег в формате `vX.Y.Z`:
   ```bash
   git tag v2.8.6
   git push origin v2.8.6
   ```

2. Или создайте релиз через GitHub UI:
   - Перейдите в раздел Releases
   - Нажмите "Draft a new release"
   - Создайте тег `vX.Y.Z`
   - Нажмите "Publish release"

3. GitHub Actions автоматически соберет бинарники для всех платформ

### 4. Установка вашей версии

Пользователи могут установить вашу версию так:

```bash
# Способ 1: Через переменную окружения
export GITHUB_REPO="ваш-username/ваш-репозиторий"
bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/install.sh)

# Способ 2: В одной команде
GITHUB_REPO="ваш-username/ваш-репозиторий" bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/install.sh)
```

### 5. Обновление до вашей версии

```bash
export GITHUB_REPO="ваш-username/ваш-репозиторий"
bash <(curl -Ls https://raw.githubusercontent.com/ваш-username/ваш-репозиторий/main/update.sh)
```

## Важные моменты

1. **По умолчанию** используется оригинальный репозиторий `MHSanaei/3x-ui`
2. **Переменная `GITHUB_REPO`** должна быть в формате `username/repository`
3. **Теги релизов** должны быть в формате `vX.Y.Z` (например, `v2.8.6`)
4. **GitHub Actions** автоматически соберет бинарники при создании релиза

## Примеры использования

### Установка оригинальной версии (по умолчанию)
```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```

### Установка вашего форка
```bash
GITHUB_REPO="your-username/your-repo" bash <(curl -Ls https://raw.githubusercontent.com/your-username/your-repo/main/install.sh)
```

### Обновление до вашего форка
```bash
GITHUB_REPO="your-username/your-repo" bash <(curl -Ls https://raw.githubusercontent.com/your-username/your-repo/main/update.sh)
```

## Дополнительная информация

Подробные инструкции по настройке форка см. в [FORK_SETUP.md](FORK_SETUP.md)

