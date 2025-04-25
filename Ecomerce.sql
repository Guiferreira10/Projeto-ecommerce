-- Criação do Banco de dados para o cenário de E-commerc
drop database ecommerce;
show databases;
create database ecommerce;
use ecommerce;

-- Criar Tabela Cliente
create table cliente(
		idCliente int auto_increment primary key,
        Fname varchar(30),
        Minit char(3),
        Lname varchar(30),
        TipoCliente enum('PF','PJ'),
        CPF_CNPJ varchar(20) not null,
        Rua varchar(255),
        Bairro varchar(255),
        Cidade varchar(255),
        Estado char(2),
        constraint unique_cpf_cnpj_client unique(CPF_CNPJ)
);

alter table cliente auto_increment = 1;

desc cliente;

-- Criar tabela de Produto

create table produto(
		idproduto int auto_increment primary key,
        Pnome varchar(30) not null,
        Classificação bool default false,
        Categoria enum('Eletronico','Vestimenta','Brinquedo','Alimentos','Móveis') not null,
        Avaliação float default 0,
        Tamanho Varchar(10)
);

alter table produto auto_increment = 1;

desc produto;

-- Criar tabela pedido
create table pedido(
		idpedido int auto_increment primary key,
        idpedidoCliente int,
        StatusPedido enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        DescriçãoPedido varchar(255),
        Valor float default 10,
        FormaPagamento enum('Crédito','Boleto'),
        constraint fk_pedido_cliente foreign key (idpedidoCliente) references cliente(idCliente)
			on update cascade
        );

alter table pedido auto_increment = 1;	

        desc pedido;
        
-- para ser continuado no desafio termine de implementar a tabela e crie a conexão com as tableas necessarias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- Criar constraint relacionadas ao pagamento

/*create table payment(
		idclient int,
        idPayment int,
        typePayment enum('Boleto','Cartão','Dois Cartões'),
        limitAcailable float,
        primary key(idClient, Idpayment)
        );*/
        
-- Criar tabela Estoque

create table Estoque(
		idEstoque int auto_increment primary key,
        Localização varchar(255),
        Quantidade int default 0
        );

alter table Estoque auto_increment = 1;

desc Estoque;

-- Criar tabela Forncedor

create table Fornecedor(
		idFornecedor int auto_increment primary key,
        SocialNome varchar(255) not null,
		CNPJ char(15) not null,
        Contato char(11) not null,
        constraint unique_Fornecedor unique (CNPJ)
        );
        
alter table Fornecedor auto_increment = 1;

desc Fornecedor;

-- Criar tabela vendedor

create table vendedor(
		idvendedor int auto_increment primary key,
        SocialNome varchar(255) not null,
        NomeFantasia varchar(255),
        CNPJ char(15),
        CPF char(15),
        Localização varchar(255),
        contato char(11) not null,
        constraint unique_cnpj_vendedor unique (CNPJ),
        constraint unique_cpf_vendedor unique (CPF)
        );

        
alter table vendedor auto_increment = 1;
        
desc vendedor;

create table produtoVendedor(
		idPVendedor int,
        idPproduto int,
        prodQuantidade int default 1,
        primary key (idPVendedor,idPproduto),
        constraint fk_produto_vendedor foreign key (idPVendedor) references Vendedor(idVendedor),
        constraint fk_produto_produto foreign key (idPproduto) references produto(idProduto)
        );
        
desc produtoVendedor;
        
create table produtoPedido(
        idPPproduto int,
        idPPpedido int,
        ppQuantidade int default 1,
        ppStatus enum('Disponível','Sem estoque') default 'Disponivel',
        primary Key (idPPproduto, idPPpedido),
		constraint fk_produtopedido_produto foreign key (idPPproduto) references produto(idProduto),
		constraint fk_produtopedido_pedido foreign key (idPPpedido) references pedido(idpedido)
        );
        
desc produtoPedido;
        
 create table estoqueLocalização(
        idLproduto int,
        idLestoque int,
        localização varchar(255) not null,
        primary Key (idLproduto, idLestoque),
		constraint fk_estoque_localização_produto foreign key (idLproduto) references produto(idproduto),
        constraint fk_estoque_localização_estoque foreign key (idLestoque) references estoque(idestoque)
        );       
	
    desc estoqueLocalização;
    
create table produtoFornecedor(
		idPfFornecedor int,
        idPfProduto int,
        quantidade int not null,
        primary key (idPfFornecedor,idPfProduto),
        constraint fk_produto_fornecedor_fornecedor foreign key (idPfFornecedor) references Fornecedor(idFornecedor),
		constraint fk_produto_fornecedor_produto foreign key (idPfProduto) references produto(idproduto)
        );
    
    desc produtoFornecedor;
    
    show tables;
    
    
    -- para encontar as contraints
    
    show databases;
    use information_schema;
    show tables;
    desc REFERENTIAL_CONSTRAINTS;
    select * from REFERENTIAL_CONSTRAINTS
    where CONSTRAINT_SCHEMA='ecommerce';
    
    desc cliente;
-- idCliente, Fname,Minit,Lname,CPF, Address
insert into cliente (Fname,Minit,Lname,tipoCliente,CPF_CNPJ,Rua,Bairro,Cidade,Estado) values
	('Camila','D','Ferreira','PF','21485396052','Rua das Rosas, 342' ,' Bairro Jardim Europa','São Paulo','SP'),
    ('Rafael','L','Soares','PJ','81245963000109','Av. Independência, 1280',' Centro','Belo Horizonte','MG'),
    ('Juliana','R','Martins','PJ','17308674000155','Rua Padre Cícero, 55' , 'Bairro Aldeota','Fortaleza','CE'),
    ('Tiago','M','Carvalho','PF','73580225040','Rua das Palmeiras, 777' , 'Copacabana', 'Rio de Janeiro','RJ'),
    ('Larissa','A','Pinto','PF','10846598000','Av. Brasil, 901 ' ,' Bairro Estação','Curitiba','PR'),
    ('Vanessa ','T','Ramos','PJ','42761589000170','Rua Getúlio Vargas, 102' ,'Centro','Florianópolis','SC'),
    ('Diego','M','Andrade','PF','85921437032','Rua Boa Esperança, 350','Bairro da Paz','Salvador','BA'),
    ('Amanda','S','Lopes','PF','14798620009','Av. Rio Branco, 670' ,' Bairro Centro','Porto Alegre','RS'),
    ('Lucas','B','Farias','PJ','30147880000102','Rua das Mangueiras, 140' ,' Bairro Coqueiral','Recife','PE');
    
    desc cliente;
    
    
    
-- idproduct, Pname, classifications_kids boolean, category('Eletrônico','Vestimenta','Brinquedos',Alimentos','Moveis'),avaliação, Size
insert into produto (Pnome,Classificação,categoria,avaliação,tamanho) values
	('Fone de ouvido',false,'Eletrônico','4',null),
    ('Barbie Elsa',True,'Brinquedo','3',null),
    ('Body Carters',True,'Vestimenta','5',null),
	('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
    ('Sofá retratil',false,'moveis','3','3x57x80'),
    ('Farinah de arroz',false,'Alimentos','2',null),
	('Fire Stick Amazon',false,'Eletrônico','3',null);
    
    desc produto;
    
-- idOrderClient, orderStatus,OrderDescription,SendValue, paymentCash
insert into pedido (idpedidoCliente,StatusPedido,DescriçãoPedido,Valor,FormaPagamento) values
	(1,default,'compra via aplicativo',null,'Crédito'),
    (2,default,'compra via aplicativo',50,'Boleto'),
    (3,'confirmado',null,null,'Crédito'),
    (4,default,'compra via web site',150,'Boleto');
    
    desc pedido;
    
 -- idPOproduct, idPOorder, poQuantity, poStatus
select * from pedido;
insert into produtoPedido (idPPproduto, idPPpedido, ppQuantidade, ppStatus) values
						 (1,5,2,null),
                         (2,5,1,null),
                         (3,6,1,null);
                         
-- storageLocation,quantity
insert into estoque (Localização,Quantidade) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
desc estoque;
                            
-- idLproduct, idLstorage, location
insert into estoqueLocalização (idLproduto, idLestoque,localização) values
						 (1,2,'RJ'),
                         (2,6,'GO');
                         
desc estoqueLocalização;

-- idSupplier, SocialName, CNPJ, contact
insert into Fornecedor (SocialNome, CNPJ, contato) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
desc Fornecedor;
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into produtoFornecedor (idPffornecedor, idPfProduto,Quantidade) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
desc produtoFornecedor;
                         
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into vendedor (SocialNome,NomeFantasia,CNPJ, CPF, Localização, Contato) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);
                        
desc vendedor;

-- idPseller, idPproduct, prodQuantity
insert into produtoVendedor (idPVendedor,idPproduto, prodQuantidade) values 
						 (1,6,80),
                         (2,7,10);
desc produtoVendedor;
                         
-- Iniciando as queries

select * from cliente c, pedido p
where c.idcliente = idpedidocliente;

select * from cliente
order by fname;

-- Quem foram as pessoas que fizeram as compras e seus dados e as informações de pagamento
select concat(Fname,' ',Lname) as Nome_Completo, TipoCliente,CPF_CNPJ as CNPJ, statusPedido,Descriçãopedido,valor, formaPagamento from cliente c, pedido p
where c.idcliente = idpedidocliente;

-- Quem são as pessoas que são PJ e fizeram as compras
select concat(Fname,' ',Lname) as Nome_Completo, TipoCliente,CPF_CNPJ as CNPJ from cliente c, pedido p
where c.idcliente = idpedidocliente and tipoCliente ='PJ';

-- informação do pedido e eendereço de entrega
select concat(Fname,' ',Lname) as Nome_Completo,concat(Rua,'-',Bairro,'-',Cidade,'-',Estado) as Endereço,
StatusPedido,valor
from cliente left outer join pedido on idcliente = idpedidocliente
order By nome_completo;



select Fname,TipoCliente,StatusPedido, descriçãoPedido,valor from cliente 
inner join pedido on idcliente = idpedidocliente
inner join produtopedido on idpedido = idPPpedido
group by idpedido;

-- Foi verificado quem comprou em que loja e dados da compra
select fname as Nome_Cliente,SocialNome as Loja,Contato as cotato_Vendedor,Pnome as Nome_produto,categoria,StatusPedido,descriçãoPedido,Valor,FormaPagamento from vendedor
inner join produtovendedor on idvendedor = idpvendedor
inner join produto on idpproduto = idproduto
inner join pedido on idpedido=idPProduto
inner join cliente on idcliente = idpedidocliente;


select * from vendedor
inner join produtovendedor on idvendedor = idpvendedor
inner join pedido on idpedido=idPProduto;


select count(*) from cliente c inner join pedido o on c.idCliente = o.idpedidocliente
			inner join produtopedido p on p.idpppedido = o.idpedido
            group by idCliente;


select fname , count(*) from cliente c inner join pedido o on c.idCliente = o.idpedidocliente
			inner join produtopedido p on p.idpppedido = o.idpedido            
            group by idCliente
            having count(*)>=2;

-- Nessa Queri vemos a os produtos que cada tem em estoque e onde eles se localizam 
select Pnome,Categoria,e.localização,e.quantidade,SocialNome as Razão_Social,CNPJ,Contato from produto
inner join estoquelocalização on idlproduto=idproduto
inner join estoque e on idlestoque = e.idestoque
inner join produtoFornecedor on idpfproduto=idproduto
inner join fornecedor on idpffornecedor = idfornecedor;

select Pnome,Categoria,e.localização,e.quantidade,SocialNome as Razão_Social,CNPJ,Contato from produto
left outer join estoquelocalização on idlproduto=idproduto
left outer join estoque e on idlestoque = e.idestoque
left outer join produtoFornecedor on idpfproduto=idproduto
left outer join fornecedor on idpffornecedor = idfornecedor;


    
        
        







