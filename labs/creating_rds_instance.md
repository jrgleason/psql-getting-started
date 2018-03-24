# Creating a RDS Instance #

## Introduction ##

AWS(Amazon Web Services) are a set of services otherwise known as a IaaS or [PaaS (Platform as a service)](https://en.wikipedia.org/wiki/Platform_as_a_service). These are designed to provide infrastructure, without needing a huge IT staff. The idea is to come up with common models and provide a hosted scalable solution to fill those models. This lab will work to teach you how to take advantage of one of these services called [RDS or Relational Data Service](https://aws.amazon.com/rds/). This service provides a SQL database, and even better it provides most major databases flavors. Even older versions of certain databases to help with compatibility issues.

## Create an RDS Instance ##

1. Ensure you have already set up an AWS account through CSCC
2. Log into [AWS](https://aws.amazon.com) using the credentials from the previous step

    ![Start Screen](./resources/start_screen.png "Start Screen")
    
    1. This is what we call the root account. Much like most operating systems you should never use the root account in real life. However, even though it is fairly simple to learn, AWS security is only covered in the additional reading. For now we will use the root account

3. Scroll down a bit and select RDS from the services menu

    ![Select RDS](./resources/Select_RDS_Screen_Small.png "Select RDS")

4. Select Launch Instance

    ![Launch Instance](./resources/Instance_List_Page_Before.png "Launch Instance")

5. On the create instance page select RDS

    ![Create Instance](./resources/Create_Instance_Page.png "Create Instance")

6. Since for this course we are using PostGRES select that database. However, notice that there are many other databases to choose from including MySQL, SQLServer, and even Amazon's own Aurora. 

    ![Select Type](./resources/Select_DB_Type.png "Select DB Type")

7. The next page provides a variety of options, to start with make sure you select dev/test to avoid additional charges.

    ![Use Case Box](./resources/AWS_Use_Case_Box.png "Use Case Box")

8. Next make sure that the micro instance type is selected

    ![Free Instance Type Selection](./resources/Free_Tier_Instance_Select.png "Free Instance Type Selection")

9. There are a few other settings that need to be set

    ![Other instance settings](./resources/Free_Tier_Extra_Settings.png "Other instance settings")
    
    1. Be careful! Since we are using the free instances we are limited to 20GBs of space. AWS warns you about this, but please don't try anything fancy.

      ![Oops Other Instance Settings](./resources/Free_Tier_Must_Be_Sub_20.png "Oops Other Instance Settings")  

    1. Make sure to take note of the *database name*, *main username*, and *password*  

10. Finally we need to configure our VPC settings. A VPC is essentially the same as using a subnet. It allows you to isolate your network environment from others. We will also create a security group, this will provide a policy to connect to the database.

    ![VPC Settings](./resources/VPC_Settings_RDS.png "VPC Settings")

11. Select Finish

    1. You should be able to see the newly created VPC in the VPC list
    
    ![VPC List](./resources/Working_VPC_List.png "VPC List")

## Allow for connections from Anywhere ##

1. Although you should be careful, it is going to be tough to rely on only connecting from 1 IP. To avoid this go to the management console.
2. Search for and select VPC
3. In the left hand menu select security group
4. Select the security group for your RDS instance (look for the port in the inbound rules)
5. Select inbound rules on the bottom 
6. Edit the rule and change

## Connect Via PSQL ##

1. Go to your AWS Management Console and Search for RDS

    ![RDS Search](./resources/RDS_Search_AWS.png)

2. On the main page select DB Instances

    ![RDS Main](./resources/RDS_main_open_instance.png)

3. Select then instance in question

    ![RDS Select Instance](./resources/RDS_select_instance.png)

4. Scroll down and find the Endpoint. This is the *public url* for the server, also make note of the *port* (should be 5432)

    ![RDS Public Address](./resources/RDS_Public_Address.png)

5. Use PSQL to [connect to the RDS db](#connect-psql) created in the last lab
    1. Use the following command `psql -h <public address> -p <port> -U <username> <database_name>`. In my case this looked like this `psql -h cscc-workforce.cmgirhyz5log.us-east-2.rds.amazonaws.com -p 5432 -U jgleason coffeeshop`

6. You should finally see the SQL prompt

    ![RDS Connect PSQL](./resources/RDS_Connect_PSQL.png)

## Takehome Work

1. Add another user to the database and log in using that user


