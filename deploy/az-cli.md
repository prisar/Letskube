iAzure Cli Commands

$ az login

$ az group create -n letskuberg -l westindia

$ az acr create -n letskubeacrprisar -g letskuberg -l centralindia --sku standard

$ az acr login -n letskubeacrprisar

$ docker push letskubeacrprisar.azurecr.io/letskube:v1

$ az acr repository list -n letskubeacrprisar -o table

$ az ad sp create-for-rbac --skip-assignment
{
  "appId": "22c91985-fa5e-43e0-b885-6d27e5fa6178",
  "displayName": "azure-cli-2018-11-06-00-23-20",
  "name": "http://azure-cli-2018-11-06-00-23-20",
  "password": "d7d6568e-313a-407a-92ca-1340e5d98c28",
  "tenant": "0a4abe47-96e8-400d-b2c5-62c0c782060e"
}



$ acrID=$( az acr show --name letskubeacrprisar --resource-group letskuberg --query "id" --output tsv )

$echo $acrID
/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/resourceGroups/letskuberg/providers/Microsoft.ContainerRegistry/registries/letskubeacrprisar

$ az role assignment create --assignee "22c91985fa5e-43e0-b885-6d27e5fa6178" --role Reader --scope $acrID

{
  "canDelegate": null,
  "id": "/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/resourceGroups/letskuberg/providers/Microsoft.ContainerRegistry/registries/letskubeacrprisar/providers/Microsoft.Authorization/roleAssignments/aad4aba9-bbf6-443d-9905-431fe692fcfb",
  "name": "aad4aba9-bbf6-443d-9905-431fe692fcfb",
  "principalId": "856165d9-8231-4010-886d-ab4c328f68c2",
  "resourceGroup": "letskuberg",
  "roleDefinitionId": "/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7",
  "scope": "/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/resourceGroups/letskuberg/providers/Microsoft.ContainerRegistry/registries/letskubeacrprisar",
  "type": "Microsoft.Authorization/roleAssignments"
}


Note: aks in not present in westindia

$ az group create -n letskubesirg -l southindia

$ az aks create --name letskubeakscluster --resource-group letskubesirg --node-count 1 --generate-ssh-keys --service-principal "22c91985-fa5e-43e0-b885-6d27e5fa6178"  --client-secret "7d6568e-313a-407a-92ca-1340e5d98c28"

{
  "aadProfile": null,
  "addonProfiles": null,
  "agentPoolProfiles": [
    {
      "count": 1,
      "maxPods": 110,
      "name": "nodepool1",
      "osDiskSizeGb": 30,
      "osType": "Linux",
      "storageProfile": "ManagedDisks",
      "vmSize": "Standard_DS2_v2",
      "vnetSubnetId": null
    }
  ],
  "dnsPrefix": "letskubeak-letskubesirg-7622b9",
  "enableRbac": true,
  "fqdn": "letskubeak-letskubesirg-7622b9-ebff70f6.hcp.southindia.azmk8s.io",
  "id": "/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/resourcegroups/letskubesirg/providers/Microsoft.ContainerService/managedClusters/letskubeakscluster",
  "kubernetesVersion": "1.9.11",
  "linuxProfile": {
    "adminUsername": "azureuser",
    "ssh": {
      "publicKeys": [
        {
          "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3+urlV7Isz4/bL6KL9kB2mYG4qneO8bTU3qnqlnU8ukWnio+r0gxHYXB+MdT9AeS2IFEaP7SYW8niUbEZRnKzGq+qBlrQNqct+DDRU+/Sz2v2YHhOt/qF/Hb6lIqeuvvT5z8/hsso4HlAN4q/hCUR87u7oAwawYvm6OC5RVOXpLhSkt8x61ZEoAB+Oqbdt79zZ76G0j30juMl33kOAYDu0FcYd0mQMeJJH1EX3BEn6Q26mBoYVoNPaw4+OXl+RAAbpJVwSPtGHlcZ/HW6jht0Wd+UZn5jf8SdnxBYWfXOS2f/l9Ft1rux6wAdBL531J5641Jr+PZZ4WL1NM1SCPvT"
        }
      ]
    }
  },
  "location": "southindia",
  "name": "letskubeakscluster",
  "networkProfile": {
    "dnsServiceIp": "10.0.0.10",
    "dockerBridgeCidr": "172.17.0.1/16",
    "networkPlugin": "kubenet",
    "networkPolicy": null,
    "podCidr": "10.244.0.0/16",
    "serviceCidr": "10.0.0.0/16"
  },
  "nodeResourceGroup": "MC_letskubesirg_letskubeakscluster_southindia",
  "provisioningState": "Succeeded",
  "resourceGroup": "letskubesirg",
  "servicePrincipalProfile": {
    "clientId": "22c91985-fa5e-43e0-b885-6d27e5fa6178",
    "secret": null
  },
  "tags": null,
  "type": "Microsoft.ContainerService/ManagedClusters"
}

$ az aks get-credentials --name letskubeakscluster --resource-group
 letskubesirg

Merged "letskubeakscluster" as current context in /Users/prisar/.kube/config

$ kubectl get nodes

NAME                       STATUS    ROLES     AGE       VERSION
aks-nodepool1-24083559-0   Ready     agent     10m       v1.9.11

$ az acr create -n letskubeacrsiprsar -g letskubesirg -l southindia
 --sku standard
{
  "adminUserEnabled": false,
  "creationDate": "2018-11-06T02:13:53.112416+00:00",
  "id": "/subscriptions/7622b9a8-3f63-4927-add9-fdc2db9f6c22/resourceGroups/letskubesirg/providers/Microsoft.ContainerRegistry/registries/letskubeacrsiprsar",
  "location": "southindia",
  "loginServer": "letskubeacrsiprsar.azurecr.io",
  "name": "letskubeacrsiprsar",
  "provisioningState": "Succeeded",
  "resourceGroup": "letskubesirg",
  "sku": {
    "name": "Standard",
    "tier": "Standard"
  },
  "status": null,
  "storageAccount": null,
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}


