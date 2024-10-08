# Microsoft Sentinel IaC

|       |       |       |
|  ---  |  ---  |  ---  |
|  [![Azure Sentinel](./media/Microsoft-Azure-sentinel.jpg "Azure Sentinel")](https://azure.microsoft.com/en-us/products/microsoft-sentinel/)     |  [![Applied Information Sciences](./media/AIS-Logo.png "AIS")](https://www.ais.com/)     |  [![Hashicorp Terraform](./media/terraform.jpg "Terraform")](https://terraform.io)     |

## Purpose

The purpose of this code is to deploy a Sentinel Instance and create an Automation playbook with a trigger already configured with the connection. This also creates the Automation rule to run after incident creation.

## Deployment Process

### Phase 1

Ensure credentials are in order either through CI/CD or DevOps solution.

The alternative is to run **az login** on your choice of terminal to ensure you have to credentials. Then ensure that you have have browsed to the proper directory and run **terraform init**

### Phase 2

***REQUIRED*** Change the following variables to allow the LogApp to be properly created on the emailnotify.json file:

1. URIFORAPICALL
2. TOKENINFO
3. DistributionGroup@emaildomain(.)tld
4. Org No Reply <noreply@clientorg(.)tld>
5. noreply@clientorg(.)tld
6. (Client Organization)

If desired, change any other variable names to required or desired naming standards using the **variables.tf** file. (***THIS IS HIGHLY RECOMMENDED***)

Once complete, run **terraform apply** via pipeline or manually through the terminal.

### Phase 3

Logon to the Azure portal:

[Commercial Azure](https://portal.azure.com)

[Government Azure](https://portal.azure.us)

In the Search bar, search for API Connections and click on the respective API connection (default = "Sentinel-API-Connection"). Then click on **Edit API Connection** then click **Authorize** then **Save**.

![API Connection Search](./media/API%20Connections%20search.png "API Connection Search")

![Sentinel API Connection](./media/API%20Connection.png "Sentinel API Connection")

![Edit API Connection](./media/edit%20api%20connection.png "edit API Connection")

![Sentinel Authorize and Save](./media/Authorize.png "Sentinel Authorize and Save")
