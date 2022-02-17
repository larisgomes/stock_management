# README

## Dependencies

* `docker`
* `docker-compose`

#### Installation instructions

* [docker](https://docs.docker.com/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

## Setting up the project

Run `docker-compose up`

## Running tests
To run specs  `docker-compose run app rspec`

## Project URL

Project runs on `localhost:3000`. You can change this editing
`docker-compose.yml` file.

## Running local

Run `docker-compose up`


## API Resources

|Verb  | URI Pattern | Description |
|------|-------------|-------------|
|GET   | /api/v1/products   | List all products. |       
|GET   | /api/v1/products/:id | Get the info for the product with the specified id. |
|POST  | /api/v1/products   | Creates a new product |
|PUT   | /api/v1/products/:id   | Update the info for the product with the specified id |
|DELETE  | /api/v1/products/:id | Delete the the product with the specified id |
|GET   | /api/v1/stores   | List all stores. |       
|GET   | /api/v1/stores/:id | Get the info for the store with the specified id. |
|POST  | /api/v1/stores   | Creates a new store |
|PUT   | /api/v1/stores/:id   | Update the info for the store with the specified id |
|DELETE  | /api/v1/stores/:id | Delete the the store with the specified id |
|GET   | /api/v1/stock_items   | List all stock items. |       
|POST  | /api/v1/stock_items   | Creates a new stock item |
|POST  | /api/v1/:operation/:stock_item_id/:amount | Update the stock (add or remove) with the amount (if is available)|

> request bodys:

### POST /api/v1/products

```json
{
    "sku": "9090123123",
    "name": "product-name",
    "cost_price": 1.9
}
```

### POST /api/v1/stores

```json
{
    "name": "store-name",
    "cnpj": "96.382.639/0001-58",
    "address_attributes": {
      "street": "Av paulista",
      "number": "123",
      "neighborhood": "Bela Vista",
      "city": "Sao Paulo",
      "state": "SP",
      "zip": "01234-090"
    }
}
```

### POST /api/v1/stock_items

```json
{
    "product_id": "9090123123",
    "store_id": "product-name",
    "amount": 10
}
```

- To add or remove items of stock:

### POST /api/v1/add/:stock_item_id/:amount

### POST /api/v1/remove/:stock_item_id/:amount
