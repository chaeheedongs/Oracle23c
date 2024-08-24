# ORACLE 23C 설치

<br/><br/><br/>



### Index

---

* [init](#init)
* [Dockerfile](#Dockerfile)
* [Docker Compose](#Docker-Compose)
* [컨테이너 실행 후 비밀번호 설정](#컨테이너-실행-후-비밀번호-설정)
* [build history](#build-history)

### init

---

```text
# Dir Tree
.
├── README.md
└── docker
    ├── Dockerfile
    ├── build.sh
    ├── docker-compose.yml
    ├── oracle-23c.tar
    ├── startup.sh
    ├── stop.sh
    └── volume

```

<br/>

> 환경구성
* Mac M1, M2, M3
* docker
* docker compose
* homebrew colima

<br/>

> 파일 설명
* docker
  * volume : 오라클 데이터베이스 볼륨 파일
  * build.sh : 초기 오라클 설치 파일
  * Dockerfile : 도커 오라클 이미지 받는 파일
  * docker-compose.yml : 도커 오라클 컨테이너 생성 파일
  * startup.sh : 콜리마와 오라클 시작 쉘 파일
  * stop.sh : 콜리마와 오라클 종료 쉘 파일

> 실행 방향

1. build.sh 실행  
2. 초기 비밀번호 설정 및 접속 확인  
3. stop.sh, startup.sh 파일로 끄고 키기 

<br/><br/><br/>

### Dockerfile

---

```dockerfile
FROM container-registry.oracle.com/database/free

CMD ["/bin/bash"]
```

> bash build-img.sh

도커 이미지가 존재하지 않을 시 build/build-img.sh 실행하면  
도커 이미지를 받아 옴  

혹시 몰라 위 경로에 24.08.24 일 기준으로  
해당 이미지를 oracle-23c.tar로 저장해놓음  

이미지가 받아지지 않을 시 해당 파일로 이미지 로드  
* docker load -i oracle-23c.tar

<br/><br/><br/>



### Docker Compose

---

```yaml
services:
  oracle:
    build:
      context: .
    image: container-registry.oracle.com/database/free:latest
    container_name: study-oracle-23c
    restart: always
    ports:
      - "1521:1521"
    environment:
      - ORACLE_PWD=oracle
    stdin_open: true
    tty: true
```

위 Dockerfile을 기반으로 이미지 생성부터 컨테이너 실행까지 compose로 만들어 놈  



<br/><br/><br/>



### 컨테이너 실행 후 비밀번호 설정

---

```text
NAMES              IMAGE                                                PORTS                                       STATUS
study-oracle-23c   container-registry.oracle.com/database/free:latest   0.0.0.0:1521->1521/tcp, :::1521->1521/tcp   Up 6 seconds (health: starting)
```

위처럼 컨테이너가 작동하고 있으면 내부에 들어가 초기 비밀번호를 설정해 주어야 한다.  

```text
$ docker exec -it study-oracle-23c bash

bash-4.4$ pwd
/home/oracle

bash-4.4$ ls
setPassword.sh

bash-4.4$ ./setPassword.sh oracle 

The Oracle base remains unchanged with value /opt/oracle

SQL*Plus: Release 23.0.0.0.0 - Production on Sat Aug 24 05:48:20 2024
Version 23.4.0.24.05

Copyright (c) 1982, 2024, Oracle.  All rights reserved.


Connected to:
Oracle Database 23ai Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.4.0.24.05

SQL> 
User altered.

SQL> 
User altered.

SQL> 
Session altered.

SQL> 
User altered.

SQL> Disconnected from Oracle Database 23ai Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.4.0.24.05

bash-4.4$ 
```

이 후에 접속하면 된다.  

system/oracle@localhost:1521/free

<br/><br/><br/>



### build history

---

```shell
# build.sh 실행

$ ./build.sh                                                                                                                                                                                              ✔ 
Homebrew 4.3.17
colima
Docker version 27.1.1, build 6312585
Docker Compose version v2.29.1-desktop.1
[+] Running 11/11
 ✔ oracle Pulled                                                                                                                                                                                                                                 253.8s 
   ✔ 6d6e36f7c9fb Pull complete                                                                                                                                                                                                                   18.6s 
   ✔ 21def9023b6f Pull complete                                                                                                                                                                                                                   18.7s 
   ✔ 5e7b2cfeb7fa Pull complete                                                                                                                                                                                                                  115.7s 
   ✔ b4a24759beff Pull complete                                                                                                                                                                                                                  238.9s 
   ✔ 78bba54e9814 Pull complete                                                                                                                                                                                                                  238.9s 
   ✔ 716b489ad5ad Pull complete                                                                                                                                                                                                                  238.9s 
   ✔ c23fd8c6cbee Pull complete                                                                                                                                                                                                                  238.9s 
   ✔ 79dea26b3a5a Pull complete                                                                                                                                                                                                                  238.9s 
   ✔ 5dfbcf799df3 Pull complete                                                                                                                                                                                                                  239.0s 
   ✔ 154719a62576 Pull complete                                                                                                                                                                                                                  251.6s 
[+] Running 1/1
 ✔ Container study-oracle-23c  Started                                                                                                                                                                                                             0.4s 
NAMES              IMAGE                                                CREATED
study-oracle-23c   container-registry.oracle.com/database/free:latest   1 second ago

# 비밀번호 초기화 
$ docker exec -it study-oracle-23c bash

bash4.4$ ./setPassword oracle

The Oracle base remains unchanged with value /opt/oracle

SQL*Plus: Release 23.0.0.0.0 - Production on Sat Aug 24 05:48:20 2024
Version 23.4.0.24.05

Copyright (c) 1982, 2024, Oracle.  All rights reserved.


Connected to:
Oracle Database 23ai Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.4.0.24.05

SQL> 
User altered.

SQL> 
User altered.

SQL> 
Session altered.

SQL> 
User altered.

SQL> Disconnected from Oracle Database 23ai Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.4.0.24.05

bash-4.4$ 
```

