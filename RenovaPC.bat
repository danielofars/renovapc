@echo off
setlocal EnableDelayedExpansion
title RenovaPC - Dando mais vida ao seu computador

REM =============================================================
REM  RENOVAPC - KIT GUIADO DE MANUTENCAO PARA COMPUTADORES LENTOS
REM  Projeto de inclusao digital: ajudar quem nao tem condicoes de
REM  trocar de computador a manter a maquina atual usavel por mais
REM  tempo, com passos explicados em linguagem simples.
REM =============================================================

REM --- Verifica privilegios de administrador -----------------------------
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo.
    echo Este programa precisa ser aberto como Administrador.
    echo Solicitando permissao...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "FLAGDIR=%ProgramData%\RenovaPC"
set "FLAGFILE=%FLAGDIR%\verificacao_ok.flag"
set "LOGFILE=%~dp0Log_RenovaPC_%COMPUTERNAME%.txt"

if not exist "%FLAGDIR%" mkdir "%FLAGDIR%" >nul 2>&1

call :log "Programa iniciado por %USERNAME% em %COMPUTERNAME%"

:boasvindas
cls
echo ================================================================
echo   RENOVAPC - Dando mais vida ao seu computador
echo ================================================================
echo.
echo   Este programa ajuda a deixar um computador lento mais rapido,
echo   sem precisar trocar de maquina. Ele foi feito para ser usado
echo   com calma, passo a passo, e sempre pedindo sua confirmacao
echo   antes de fazer qualquer alteracao.
echo.
echo   RECOMENDADO: se possivel, use este programa com a ajuda de
echo   uma pessoa com experiencia em informatica, principalmente
echo   nas opcoes marcadas como "Avancado".
echo.
echo   IMPORTANTE: antes de continuar, confirme que fotos, documentos
echo   e arquivos importantes estao salvos em outro lugar (pen drive,
echo   nuvem, e-mail). Este computador pode nao ter um Ponto de
echo   Restauracao configurado.
echo ----------------------------------------------------------------
pause
goto menu

:menu
cls
echo ================================================================
echo   RENOVAPC - Menu Principal
echo ================================================================
echo   Escolha uma opcao digitando o numero e pressionando Enter.
echo ----------------------------------------------------------------
echo   1  - Limpar arquivos temporarios              [Iniciante]
echo   2  - Limpar arquivos antigos do Windows Update [Iniciante]
echo   3  - Limpeza de Disco (ferramenta do Windows)  [Iniciante]
echo   4  - Otimizar o disco (deixar a leitura rapida) [Iniciante]
echo   5  - Melhorar o desempenho visual               [Iniciante]
echo   6  - Verificacao avancada do sistema (DISM/SFC) [Avancado]
echo   7  - Verificacao fisica do disco (ChkDsk)       [Avancado]
echo   8  - Ativar limpeza automatica no futuro        [Iniciante]
echo   0  - Sair
echo ----------------------------------------------------------------
set /p opc="Digite o numero da opcao desejada: "

if "%opc%"=="1" goto passo1
if "%opc%"=="2" goto passo2
if "%opc%"=="3" goto passo3
if "%opc%"=="4" goto passo4
if "%opc%"=="5" goto passo5
if "%opc%"=="6" goto passo6
if "%opc%"=="7" goto passo7
if "%opc%"=="8" goto passo8
if "%opc%"=="0" goto fim
echo Opcao invalida. Tente novamente.
pause
goto menu

REM =============================================================
REM  PASSO 1 - ARQUIVOS TEMPORARIOS
REM =============================================================
:passo1
cls
echo ================================================================
echo   1 - LIMPAR ARQUIVOS TEMPORARIOS
echo ================================================================
echo   O que isso faz: remove arquivos que os programas criam para
echo   uso temporario e nunca apagam sozinhos. Isso libera espaco e
echo   ajuda o computador a responder mais rapido. E seguro para a
echo   grande maioria dos casos.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 1 - Limpeza de arquivos temporarios iniciada"
pushd "%temp%" 2>nul
for /f "delims=" %%F in ('dir /b /a-d 2^>nul') do del /f /q "%%F" >nul 2>&1
for /f "delims=" %%D in ('dir /b /ad 2^>nul') do rd /s /q "%%D" >nul 2>&1
popd
echo.
echo Pronto! Alguns arquivos podem ter sido ignorados por estarem em uso
echo no momento - isso e normal e nao e um problema.
call :log "Passo 1 - Limpeza de arquivos temporarios concluida"
pause
goto menu

REM =============================================================
REM  PASSO 2 - CACHE DO WINDOWS UPDATE
REM =============================================================
:passo2
cls
echo ================================================================
echo   2 - LIMPAR ARQUIVOS ANTIGOS DO WINDOWS UPDATE
echo ================================================================
echo   O que isso faz: apaga uma pasta onde o Windows guarda copias
echo   de atualizacoes ja instaladas ou com problema. O Windows
echo   recria essa pasta sozinho, entao isso e seguro.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 2 - Limpeza de SoftwareDistribution iniciada"
echo Pausando servicos do Windows Update por um momento...
net stop wuauserv
net stop bits
net stop cryptsvc
echo Apagando arquivos antigos...
rd /s /q "%windir%\SoftwareDistribution" >nul 2>&1
mkdir "%windir%\SoftwareDistribution" >nul 2>&1
echo Reativando os servicos...
net start wuauserv
net start bits
net start cryptsvc
echo.
echo Pronto!
call :log "Passo 2 - Limpeza de SoftwareDistribution concluida"
pause
goto menu

REM =============================================================
REM  PASSO 3 - LIMPEZA DE DISCO
REM =============================================================
:passo3
cls
echo ================================================================
echo   3 - LIMPEZA DE DISCO (FERRAMENTA DO PROPRIO WINDOWS)
echo ================================================================
echo   O que isso faz: abre a ferramenta oficial do Windows para
echo   apagar lixo do sistema (miniaturas, lixeira, arquivos
echo   temporarios). Voce mesmo escolhe o que apagar na tela que
echo   vai abrir.
echo.
echo   CUIDADO: na tela que vai abrir, NAO marque a opcao
echo   "Instalacao anterior do Windows" (Windows.old) nem itens de
echo   backup - apagar isso impede desfazer uma atualizacao recente.
echo   Na duvida sobre algum item, deixe desmarcado.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar e abrir a ferramenta? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 3 - Limpeza de Disco aberta"
start /wait cleanmgr /d %systemdrive%
echo.
echo Janela fechada. Pronto!
call :log "Passo 3 - Limpeza de Disco concluida"
pause
goto menu

REM =============================================================
REM  PASSO 4 - OTIMIZAR O DISCO
REM =============================================================
:passo4
cls
echo ================================================================
echo   4 - OTIMIZAR O DISCO (DEIXAR A LEITURA MAIS RAPIDA)
echo ================================================================
echo   O que isso faz: reorganiza os arquivos no disco para o
echo   computador ler mais rapido. O proprio Windows identifica o
echo   tipo de disco (HD antigo ou SSD) e escolhe o metodo certo
echo   automaticamente - voce nao precisa saber qual e o seu.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 4 - Otimizacao de disco iniciada"
defrag %systemdrive% /O
echo.
echo Pronto!
call :log "Passo 4 - Otimizacao de disco concluida"
pause
goto menu

REM =============================================================
REM  PASSO 5 - DESEMPENHO VISUAL
REM =============================================================
:passo5
cls
echo ================================================================
echo   5 - MELHORAR O DESEMPENHO VISUAL
echo ================================================================
echo   O que isso faz: abre uma tela do Windows onde voce pode
echo   desligar efeitos visuais (sombras, animacoes) que consomem
echo   memoria e deixam o computador mais lento. Isso deixa o
echo   visual mais simples, mas mais rapido.
echo.
echo   Na tela que vai abrir, escolha a opcao "Ajustar para obter
echo   um melhor desempenho" e clique em Aplicar e depois em OK.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar e abrir a tela? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 5 - Ajuste de desempenho visual aberto"
start /wait SystemPropertiesPerformance.exe
echo.
echo Pronto!
call :log "Passo 5 - Ajuste de desempenho visual concluido"
pause
goto menu

REM =============================================================
REM  PASSO 6 - VERIFICACAO AVANCADA (DISM/SFC)
REM =============================================================
:passo6
cls
echo ================================================================
echo   6 - VERIFICACAO AVANCADA DO SISTEMA (DISM e SFC)   [Avancado]
echo ================================================================
echo   O que isso faz: verifica e conserta arquivos do sistema
echo   Windows que possam estar corrompidos. Pode resolver travamentos
echo   que a limpeza simples nao resolve.
echo.
echo   ATENCAO: esta e uma etapa avancada. Recomendado apenas com
echo   apoio de alguem com experiencia em informatica. Precisa de
echo   internet, pode demorar de 5 a 20 minutos, e o computador nao
echo   pode ser desligado no meio do processo.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar mesmo assim? (S/N): "
if /i not "%ok%"=="S" goto menu
call :log "Passo 6 - DISM /RestoreHealth iniciado"
echo.
echo Etapa 1 de 2: reparando a imagem do Windows (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "Passo 6 - DISM finalizado com codigo %errorlevel%"
echo.
echo Etapa 2 de 2: verificando arquivos protegidos do sistema (SFC)...
sfc /scannow
call :log "Passo 6 - SFC finalizado com codigo %errorlevel%"
echo.
echo ================================================================
echo   VERIFICACAO CONCLUIDA. REINICIE O COMPUTADOR AGORA.
echo ================================================================
echo Se aparecerem erros que nao puderam ser corrigidos, procure
echo apoio tecnico antes de tentar novamente.
echo.
set /p rst="Deseja reiniciar o computador agora? (S/N): "
if /i "%rst%"=="S" (
    call :log "Reinicializacao solicitada apos o Passo 6"
    shutdown /r /t 30 /c "Reinicializacao apos verificacao RenovaPC. Cancele com 'shutdown /a' se necessario."
)
pause
goto menu

REM =============================================================
REM  PASSO 7 - VERIFICACAO FISICA DO DISCO (ChkDsk)
REM =============================================================
:passo7
cls
echo ================================================================
echo   7 - VERIFICACAO FISICA DO DISCO (ChkDsk)          [Avancado]
echo ================================================================
echo   O que isso faz: verifica se o disco tem setores com defeito
echo   fisico. Use somente se o computador continuar muito lento ou
echo   travando depois das outras opcoes, e se houver suspeita de
echo   problema no disco.
echo.
echo   ATENCAO: esta e uma etapa avancada. Recomendado apenas com
echo   apoio de alguem com experiencia em informatica, pois usar a
echo   opcao errada pode desgastar um SSD sem necessidade.
echo ----------------------------------------------------------------
set /p ok="Deseja continuar mesmo assim? (S/N): "
if /i not "%ok%"=="S" goto menu
echo.
echo Antes de escolher, veja o tipo do disco em: Explorador de
echo Arquivos ^> Este Computador ^> botao direito no disco C: ^>
echo Propriedades ^> aba Ferramentas ^> Otimizar - a coluna "Tipo de
echo midia" mostra HDD (disco antigo) ou SSD (mais novo e rapido).
echo ----------------------------------------------------------------
echo   1 - HDD (disco antigo, mecanico)
echo   2 - SSD (disco de estado solido, mais novo)
echo   0 - Cancelar
echo ----------------------------------------------------------------
set /p disco="Qual e o tipo do disco? "
if "%disco%"=="1" (
    call :log "Passo 7 - ChkDsk agendado para HDD (/f /r /x)"
    echo.
    echo Agendando verificacao completa. Quando for pedido, confirme
    echo com "S" para agendar na proxima reinicializacao.
    chkdsk %systemdrive% /f /r /x
    echo.
    echo Verificacao agendada. REINICIE O COMPUTADOR para ela rodar.
    echo Pode levar horas, dependendo do tamanho do disco.
) else if "%disco%"=="2" (
    call :log "Passo 7 - ChkDsk agendado para SSD (/f /x)"
    echo.
    echo Agendando verificacao. Quando for pedido, confirme com "S"
    echo para agendar na proxima reinicializacao.
    chkdsk %systemdrive% /f /x
    echo.
    echo Verificacao agendada. REINICIE O COMPUTADOR para ela rodar.
) else (
    echo Cancelado. Nenhum comando foi executado.
)
pause
goto menu

REM =============================================================
REM  PASSO 8 - LIMPEZA AUTOMATICA NO FUTURO (STORAGE SENSE)
REM =============================================================
:passo8
cls
echo ================================================================
echo   8 - ATIVAR LIMPEZA AUTOMATICA NO FUTURO (Storage Sense)
echo ================================================================
echo   O que isso faz: liga um recurso do Windows que limpa lixo do
echo   sistema sozinho, de tempos em tempos, para o computador nao
echo   voltar a ficar lento tao rapido.
echo.
echo   Configuracao recomendada:
echo    - Rodar quando o espaco em disco estiver ficando baixo
echo    - Esvaziar a Lixeira automaticamente apos 14 dias
echo    - Apagar arquivos nao usados da pasta Downloads apos 30 dias
echo ----------------------------------------------------------------
set /p ok="Deseja ativar agora? (S/N): "
if /i not "%ok%"=="S" goto menu
echo.
echo Aplicando a configuracao recomendada...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 04 /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 08 /t REG_DWORD /d 14 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 32 /t REG_DWORD /d 30 /f >nul
call :log "Storage Sense configurado automaticamente"
echo Pronto! Abrindo a tela de configuracoes para voce conferir...
start ms-settings:storagesense
pause
goto menu

REM =============================================================
REM  FUNCAO DE REGISTRO (LOG)
REM =============================================================
:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
exit /b

:fim
call :log "Programa encerrado por %USERNAME%"
echo.
echo ================================================================
echo   Obrigado por usar o RenovaPC!
echo ================================================================
echo Ultimo passo: reinicie o computador para que todas as
echo alteracoes feitas hoje tenham efeito completo.
echo.
echo Se este programa ajudou voce, considere indicar para outras
echo pessoas ou escolas/ONGs que possam se beneficiar.
pause
endlocal
exit /b
