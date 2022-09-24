# DB-Ecommerce

Schema Relaciona de Banco de Dados para E-commerce

Lista de Tabelas utilizadas:

- Clientes
- Produtos
- Pedidos
- Envio
- Pagamento
- Produto do Pedido

# Image do Schema

![db_schema](https://github.com/Muamm4/DB-Ecommerce/blob/main/db_schema.png)


# Exemplo de uso


- Cadastro e clientes
- Registro o pedido do cliente, juntamente relacionado com os produtos disponíveis na loja, sendo utilizado a tabela "Produto do Pedido", onde ficara armazenado os tipos de produtos que estão relacionado ao 'Pedido_id' computando quantidade e valor do produto.
- Realização do pagamento atrelado ao 'Pedido_id' verificado seu status
- Tabela de "Envio" para verificar os pedidos em sua situação de entrega, se a remessa tenha esta em estado de produção, enviado, ou entregue.
