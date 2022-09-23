# DB-Ecommerce

Schema Relaciona de Banco de Dados para E-commerce

Lista de Tabelas utilizadas:

- client
- product
- order
- order products
- shipping
- payments

# Image do Schema

![db_schema](https://github.com/Muamm4/DB-Ecommerce/blob/main/%C3%ADndice.png)


# Exemplo de uso


- Cadastro e clientes
- Registro o pedido do cliente, juntamente relacionado com os produtos disponíveis na loja, sendo utilizado a tabela "order_products", onde ficara armazenado os tipos de produtos que estão relacionado ao 'order_id' computando quantidade e valor do produto.
- Realização do pagamento atrelado ao 'order_id' verificado seu status
- Tabela de "Shipping" para verificar os pedidos em sua situação de entrega, se a remessa tenha esta em estado de produção, enviado, ou entregue.
