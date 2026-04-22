#!/bin/bash
#
# Script otimizado para o monitoramento do Zabbix.
# Autor: Daniel Amarante
# Manutenção: Daniel Amarante
# Data: 2024-06-20
# Versão: 1.0
# Descrição: Verifica o status de um site e retorna o código HTTP ou -1 em caso de erro.
#
#------------------------------------------------------------------------------------------
# Instruções de uso:
# Exemplo de uso do script:
# $ ./verifica_site.sh
#------------------------------------------------------------------------------------------
#
# Histórico de alterações:
#
#
# Versão 1.0 - 2024-06-20: Criação do script para monitoramento do Zabbix.
#-------------------------------------------------------------------------------------------



URL="http://127.0.0.1:5500/shellScript.html"
STATUS_ERROR=-1

# Captura o status (timeout de 5s para não travar o agente)
STATUS=$(curl -o /dev/null -s -m 5 -w "%{http_code}" "$URL")

if [ "$STATUS" -eq 200 ]; then
    echo "$STATUS"
else
    # Se o curl falhar (status 000) ou for erro, retorna -1
    echo "$STATUS_ERROR"
fi