# MySQL 脱敏函数使用
https://github.com/hcymysql/data_mask_function

## 1. 身份证号、手机号、银行卡号 采用 Percona data_masking.so 插件脱敏
https://docs.percona.com/percona-server/8.0/data-masking-plugin-functions.html

### 安装脱敏插件
```
mysql> INSTALL PLUGIN data_masking SONAME 'data_masking.so';

mysql> SELECT * FROM INFORMATION_SCHEMA.PLUGINS WHERE PLUGIN_NAME LIKE 'data%'\G;
*************************** 1. row ***************************
           PLUGIN_NAME: data_masking
        PLUGIN_VERSION: 1.0
         PLUGIN_STATUS: ACTIVE
           PLUGIN_TYPE: DAEMON
   PLUGIN_TYPE_VERSION: 80031.0
        PLUGIN_LIBRARY: data_masking.so
PLUGIN_LIBRARY_VERSION: 1.11
         PLUGIN_AUTHOR: Francisco Miguel Biete Banon
    PLUGIN_DESCRIPTION: Data Masking plugin
        PLUGIN_LICENSE: GPL
           LOAD_OPTION: ON
1 row in set (0.00 sec)
```

### 使用脱敏插件
#### 1. 身份证
```
mysql> SELECT mask_inner('110101199901011234',6, 2, '*') AS ID_card;
+--------------------+
| ID_card            |
+--------------------+
| 110101**********34 |
+--------------------+
1 row in set (0.00 sec)
```
#### 注：保留身份证号的前6位和后2位，中间部分用'*'替代


#### 2. 手机号
```
mysql> SELECT mask_inner('13912345678', 3, 2, '*') AS mobile;
+-------------+
| mobile      |
+-------------+
| 139******78 |
+-------------+
1 row in set (0.00 sec)
```
#### 注：保留手机号的前3位和后2位，中间部分用'*'替代

------------------------------------
## 2. 邮箱、姓名、地址 采用 自主编写的脱敏函数
### 安装脱敏函数
```
mysql> use yourDB;
mysql> source /tmp/mask_email.sql;
mysql> source /tmp/mask_address.sql;
mysql> source /tmp/mask_chinese_name.sql;
```

### 使用脱敏函数
#### 1. 邮箱
```
mysql> SELECT mask_email('abc@sohu.com') AS email;
+---------------+
| email         |
+---------------+
| xxxx@sohu.com |
+---------------+
1 row in set (0.00 sec)
```

#### 2. 姓名
```
mysql> SELECT mask_chinese_name('张三') AS name;
+------+
| name |
+------+
| 张*  |
+------+
1 row in set (0.01 sec)

mysql> SELECT mask_chinese_name('张某三') AS name;
+-------+
| name  |
+-------+
| 张**  |
+-------+
1 row in set (0.00 sec)
```

#### 3. 家庭住址
```
mysql> SELECT mask_address('北京市朝阳区霄云路8号') AS address;
+-------------------------+
| address                 |
+-------------------------+
| 北京市朝阳区*****       |
+-------------------------+
1 row in set (0.00 sec)
```
