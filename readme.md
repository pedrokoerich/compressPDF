# PDF Compression Script Using Ghostscript / Script de Compressão de PDFs Usando Ghostscript

Este repositório contém um script em batch para comprimir arquivos PDF usando **Ghostscript** e movê-los para uma pasta específica (`compressed_files`). O script funciona comprimindo todos os arquivos PDF no diretório atual e salvando as versões comprimidas na pasta `compressed_files`.

## Prerequisites / Pré-requisitos

- **Ghostscript** deve estar instalado na sua máquina. Você pode baixá-lo no site oficial: [Download do Ghostscript](https://www.ghostscript.com/download/gsdnld.html)
- Adicione o Ghostscript à variável de ambiente `PATH` do sistema, ou modifique o script para apontar para o caminho absoluto do executável do Ghostscript.

## How it works / Como funciona

- O script faz um loop por todos os arquivos `.pdf` no diretório atual.
- Para cada PDF, o Ghostscript é usado para aplicar a compressão.
- O PDF compactado é salvo em uma nova pasta chamada `compressed_files`.

## Usage / Uso

1. Clone este repositório ou baixe o script.
2. Certifique-se de que a variavel (`GSPATH`) está recebendo o caminho certo da instalação do GhostScript. (O caminho pode variar de acordo com a versão instalada)
3. Coloque o script (`compress.bat`) em uma pasta que contenha os PDFs que você deseja comprimir.
4. Dê um duplo clique no arquivo `.bat` para executá-lo.
5. Os PDFs compactados serão salvos na pasta `compressed_files`.

## Script Details / Detalhes do Script

```batch
@echo off
setlocal

rem Definir o diretório de saída
set GS_OUTPUT_DIR=compressed_files

rem Caminho para o executável Ghostscript (ajuste se necessário)
set GSPATH=C:\Program Files\gs\gs10.04.0\bin\gswin64c.exe

rem Criar a pasta de saída se ela não existir
if not exist "%GS_OUTPUT_DIR%" (
    mkdir "%GS_OUTPUT_DIR%"
)

rem Verificar se existe algum arquivo PDF na pasta atual
if not exist *.pdf (
    echo Nenhum arquivo PDF foi encontrado na pasta atual.
    pause
    exit /b
)

rem Compactar cada arquivo PDF na pasta atual usando Ghostscript diretamente
for %%i in (*.pdf) do (
    echo Compactando "%%i"...
    
    rem Executar o Ghostscript para compressão de PDF
    "%GSPATH%" -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageResolution=144 -sOutputFile="%GS_OUTPUT_DIR%\%%i" "%%i"
    
    rem Verificar se o arquivo foi criado corretamente
    if exist "%GS_OUTPUT_DIR%\%%i" (
        echo O arquivo "%%i" foi compactado com sucesso.
    ) else (
        echo Erro ao compactar o arquivo "%%i".
    )
)

echo Todos os PDFs foram processados.
pause
