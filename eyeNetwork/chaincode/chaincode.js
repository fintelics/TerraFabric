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

    async addAdProvider(name, balance) {

    }


    async updataIssuerBalance(newBalance) {

    }

    async adProviderTopVideoProvider(adPid, vPid, adId, vId, amount, ) {

    }
    async tokenIssuerToadProvider() {

    }
    async videoToTokenIssuer() {

    }

    async addVideoProvider(name, balance) {

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
            consolo.log(err);
            return shim.error(err);
        }
    }

    async initDatabase(stub,args){
        console.info('=====================Start: the system is about to start======================');
        let tokenIssuer={
            balance: "10000"
        };
        /*
        let adAdProvider=[];
        let video=[];
        let videoProvider=[];
        */

        await stub.putState('tokenIssure',Buffer.from(JSON.stringify(tokenIssuer)));
        console.info("tokenIssure has already been generated with balance: ", tokenIssuer.balance);
        
    }


}







shim.start(new Chaincode());