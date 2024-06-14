# Sock Shop Deployment

## Шаги для развертывания

1. Клонируйте репозиторий:

    ```bash
    git clone <URL вашего репозитория>
    cd <название вашего репозитория>
    ```

2. Инициализируйте Terraform:

    ```bash
    terraform init
    ```

3. Примените конфигурацию:

    ```bash
    terraform apply
    ```

4. Подключитесь к `manager` ноде и получите токен для присоединения worker-нод:

    ```bash
    docker swarm join-token worker
    ```

5. Подключитесь к `worker1` и `worker2` и выполните команду для присоединения к Swarm:

    ```bash
    docker swarm join --token <TOKEN> <manager_ip>:2377
    ```

6. Деплойте стек:

    ```bash
    docker stack deploy -c docker-compose.yml sock-shop
    ```

7. Масштабируйте frontend-сервис:

    ```bash
    docker service scale sock-shop_front-end=2
    ```

## Проверка

1. Откройте внешний IP-адрес `manager` ноды в браузере.
2. Выполните команды для проверки:

    ```bash
    docker service ls
    docker node ls
    ```


- **Вывод команды `docker service ls`:**

  
    ```

- **Вывод команды `docker node ls`:**

 
