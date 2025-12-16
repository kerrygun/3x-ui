#!/bin/bash

# Скрипт для слияния изменений из оригинального репозитория 3x-ui

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
plain='\033[0m'

echo -e "${green}=== Слияние изменений из upstream репозитория ===${plain}"

# Проверка наличия upstream
if ! git remote | grep -q upstream; then
    echo -e "${yellow}Upstream не найден. Добавляю upstream...${plain}"
    git remote add upstream https://github.com/MHSanaei/3x-ui.git
fi

# Получение последних изменений
echo -e "${green}Получение последних изменений из upstream...${plain}"
git fetch upstream

# Определение текущей ветки
current_branch=$(git branch --show-current)
echo -e "${blue}Текущая ветка: ${current_branch}${plain}"

# Проверка наличия незакоммиченных изменений
if ! git diff-index --quiet HEAD --; then
    echo -e "${yellow}Обнаружены незакоммиченные изменения.${plain}"
    read -p "Хотите сохранить их в stash? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git stash push -m "Stash before merge upstream"
        stash_created=true
    else
        echo -e "${red}Отмена операции. Пожалуйста, закоммитьте или отмените изменения.${plain}"
        exit 1
    fi
fi

# Слияние изменений
echo -e "${green}Слияние изменений из upstream/main...${plain}"
if git merge upstream/main --no-edit; then
    echo -e "${green}✓ Слияние выполнено успешно!${plain}"
    
    # Восстановление stash, если был создан
    if [ "$stash_created" = true ]; then
        echo -e "${yellow}Восстановление сохраненных изменений...${plain}"
        git stash pop
    fi
    
    echo -e "${green}=== Готово! ===${plain}"
    echo -e "${blue}Следующие шаги:${plain}"
    echo -e "1. Проверьте изменения: ${yellow}git log HEAD..upstream/main${plain}"
    echo -e "2. Протестируйте изменения"
    echo -e "3. Если все хорошо, запушите: ${yellow}git push origin ${current_branch}${plain}"
else
    echo -e "${red}✗ Обнаружены конфликты при слиянии!${plain}"
    echo -e "${yellow}Разрешите конфликты вручную, затем выполните:${plain}"
    echo -e "  ${blue}git add .${plain}"
    echo -e "  ${blue}git commit${plain}"
    
    # Восстановление stash, если был создан
    if [ "$stash_created" = true ]; then
        echo -e "${yellow}Восстановление сохраненных изменений...${plain}"
        git stash pop
    fi
    
    exit 1
fi

