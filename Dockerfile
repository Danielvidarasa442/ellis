# 1. Usar uma imagem base Python slim. É uma boa prática para produção.
# A imagem 'slim' é menor que a padrão, mas tem melhor compatibilidade que a 'alpine' para algumas bibliotecas.
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# 4. Instalar as dependências
# O --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o resto do código da sua aplicação para o diretório de trabalho
COPY . .

# 6. Comando para iniciar a aplicação quando o contêiner for executado
# Use "0.0.0.0" para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]