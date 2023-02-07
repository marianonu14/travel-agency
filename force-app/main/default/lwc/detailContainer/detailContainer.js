import { LightningElement, api } from 'lwc';
import createTravel from '@salesforce/apex/DataGenerator.createTravel';

export default class DetailContainer extends LightningElement {
    @api getValueFromParent;

    handleClick(){
        createTravel({
            name: 'PTY-AEP',
            Id: 'a01Dn00000D94i4IAB',
            finalPrice: 200,
            baggage: 'Bags',
            classFlight: 'Economy',
        })
            .then( result => {
                console.log(result);
            })
            .catch(error => {
                console.log(error);
            })

    }
}