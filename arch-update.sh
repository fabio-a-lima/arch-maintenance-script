VERDE="\e[32m"
AZUL="\e[34m"
AMARELO="\e[33m"
RESET="\e[0m"

set -e

echo -e "${VERDE}==> INICIANDO MANUTENÇÃO DO ARCH LINUX <==${RESET}"

echo -e "\n${AZUL}==> 1. Sincronizando repositórios e atualizando o sistema...${RESET}"
yay --noconfirm
echo -e "${VERDE}Sistema atualizado com sucesso!${RESET}"

echo -e "\n${AZUL}==> 2. Limpando cache de pacotes antigos (mantendo os 3 últimos)...${RESET}"

sudo paccache -r
echo -e "${VERDE}Cache limpo!${RESET}"

echo -e "\n${AZUL}==> 3. Procurando por pacotes órfãos...${RESET}"

orphans=$(pacman -Qdtq || true)

if [ -z "$orphans" ]; then

    echo -e "${VERDE}Nenhum pacote órfão encontrado. Tudo limpo!${RESET}"
else

    echo -e "${AMARELO}Pacotes órfãos encontrados:${RESET}"
    echo "$orphans"
    echo -e "${AMARELO}Removendo órfãos...${RESET}"
    sudo pacman -Rns --noconfirm $orphans
    echo -e "${VERDE}Pacotes órfãos removidos!${RESET}"
fi

echo -e "\n${VERDE}==> MANUTENÇÃO CONCLUÍDA! ✔ <==${RESET}"