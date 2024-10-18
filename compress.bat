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
