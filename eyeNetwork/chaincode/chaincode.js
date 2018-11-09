/**
 * Copyright finetelics . All Rights Reserved.
 * 
 * SPDX-License-Identifier: Apache-2.0
 */



/**
 * Schema:  
 * 
 * toker issuer / video provider / ad provider 
 * 
 * token issuer init with one fixed credit，then transfer to ad provider once triggered
 * and ad provider can send fixed amount of token to video provider
 * 
 * Update balance of token issuer
 * 
 * 
 */

const shim = require('fabric-shim');
const util = require('util');


var Chaincode = class {

    
    async Init(stub) {
        console.info('===============Eye network transfer system start================')
        /**
         * Every time this chaincodein Init 
         */
        return shim.success()

    }

    async addAdProvider(stub, name, id, balance) {
        let newAdProvider={
            providerName: name,
            providerId: id,
            balance: balance
        }
        await stub.putState('adProvider '+newAdProvider.providerId, 
                              Buffer.from(JSON.stringify(newAdProvider)));
        console.log('adProvider '+newAdProvider.providerId+' has already been added with balance '+newAdProvider.balance);
    }


    async updateTokenBalance(stub, newBalance) {
        console.info('=================Start: update token balance=====================');
        if (newBalance<=0){
            throw new Error('new balance can not be negative');
        }
        let tokenIssuerBytes = await stub.getState('tokenIssuer');
        let tokenIssuer=JSON.parse(tokenIssuerBytes);
        tokenIssuer.balance=newBalance;
        await stub.putState('tokenIssuer',JSON.stringify(tokenIssuer));
        console.info('====================END: token balance is updated================');

    }

    async adProvider2VideoProvider(stub, adPid, vPid, adId, vId, amount, ) {
        console.info('=============Transaction happen===============');
        let adProviderByte= await stub.getState('adProvider '+adPid)
        let adProvider=JSON.parse(adProviderByte);
        let videoProviderByte= await stub.getState('videoProvider '+vPid);
        let videoProvider=JSON.parse(videoProviderByte);

        adProvider.balance=adProvider.balance-amount;
        videoProvider.balance=videoProvider.balance+amount;
        await stub.putState('adProvider '+adPid,JSON.stringify(adProvider));
        await stub.putState('videoProvider '+vPid,JSON.stringify(videoProvider));
        console.info("transaction is done. ad provider "+adPid+" paid "+amount+" token to video provider "
                        +vPid+" to attach ad "+adId+ " on video "+vid);

    }
    async tokenIssuer2AdProvider(stub,adPid,amount) {
        console.info('===================Transaction happen=================');
        let adProviderByte= await stub.getState('adProvider '+adPid)
        let adProvider=JSON.parse(adProviderByte);
        let tokenIssuerBytes = await stub.getState('tokenIssuer');
        let tokenIssuer=JSON.parse(tokenIssuerBytes);

        tokenIssuer.balance=tokenIssuer.balance-amount;
        adProvider.balance=adProvider.balance+amount;

        await stub.putState('videoProvider '+vPid,JSON.stringify(videoProvider));
        await stub.putState('tokenIssuer',JSON.stringify(tokenIssuer));

    }
    async videoProvider2TokenIssuer(stub,vPid,amount) {
        console.info('===================Transaction happen=================');
        let tokenIssuerBytes = await stub.getState('tokenIssuer');
        let tokenIssuer=JSON.parse(tokenIssuerBytes);
        let videoProviderByte= await stub.getState('videoProvider '+vPid);
        let videoProvider=JSON.parse(videoProviderByte);

        tokenIssuer.balance=tokenIssuer.balance+amount;
        videoProvider.balance=videoProvider.balance-amount;

        await stub.putState('tokenIssuer',JSON.stringify(tokenIssuer));
        await stub.putState('videoProvider '+vPid,JSON.stringify(videoProvider));
    }

    async addVideoProvider(stub, name, id, balance) {
        let newAdProvider={
            providerName: name,
            providerId: id,
            balance: balance
        }
        await stub.putState('videoProvider'+ newAdProvider.providerId,
                                  Buffer.from(JSON.stringify(newAdProvider)));
        console.log('videoProvider '+newVideoProvider.providerId+' has already been added with balance '+newVideoProvider.balance);
    }




    async Invoke(stub) {
        let ret = stub.getFunctionAndParameters();
        console.info(ret);
        let args = ret.params;
        let method = this[ret.fcn];
        if (!method) {
            console.error('no function of name :' + ret.fcn + ' found');
            throw new Error('Received unknown function ' + ret.fcn + ' invocation');
        } try{
            let payload = await method(stub,ret.params);
            return shim.success(payload);
        }
        catch(err){
            console.log(err);
            return shim.error(err);
        }
    }

    async initDatabase(stub,args){
        console.info('=====================Start: the system is about to start======================');
        let tokenIssuer={
            balance: "10000"
        };
        await stub.putState('tokenIssuer',Buffer.from(JSON.stringify(tokenIssuer)));
        console.info("tokenIssuer has already been generated with balance: ", tokenIssuer.balance);
        
    }


}



shim.start(new Chaincode());