# A little explanation on chain code for eyeNetwork 

This chaincode here basically deals with the transaction happened between tokenIssuer, which represents as admin of eye network, video provider and advertisement provider.

For right now, the balance of token issuer is 100000 token once the network is launched. Balance updating command is also reserved. 

`initDatabase` (null)
```
Initialize the database by creating role token issuer with balance 10000 
```


`addVideoProvider` (`name`,`id`,`balance`)
```
Create a new video provider with name, id and specified balance
```

`addAdProvider` (`name`,`id`,`balance`)
```
Create a new advertisement provider with name, id and specified balance
```

`videoProvider2TokenIssuer` (`vpId`,`amount`)
``` 
Transaction happened between video provider and token issuer.

vpId refers to the id of video provider.  amount refers to the amount of tokens that video provider wants to pay.

This method only be triggered once video provider wants to cash out by equal value. Balance of video provider and token issuer will be both updated. 
```

`tokenIssuer2AdProvider` (`apId`,`amount`)
``` 
Transaction happened between advertisement provider and token issuer. 

apId refers to the id of advertisement provider.  amount refers to the amount of tokens that advertisement provider wants to buy from token issuer.

This method only be triggered once advertisement provider wants to buy tokens. Balance of advertisement provider and token issuer will be both updated. 
```

`adProvider2VideoProvider` (`apId`,`vpId`,`amount`)
``` 
Transaction happened between advertisement provider and video provider.

apId refers to the id of advertisement provider. vpId refers to the id of video provider. amount refers to the amount of tokens that advertisement provider wants to pay to video provider for one period of time.

This method only be triggered once advertisement provider wants to buy tokens. Balance of advertisement provider and token issuer will be both updated. 

One future feature is to introduce one asset called video, and this transaction also update the available time of it.

```
`updateTokenBalance` (`amount`)
```
Update the balance of token issuer to control the rate between token and currency in real world

```


