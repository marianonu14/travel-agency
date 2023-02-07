import getScale from '@salesforce/apex/getScales.getScale';
import { LightningElement, wire } from 'lwc';

export default class ComboboxBasic extends LightningElement {
    origin = 'MVD';
    destination = 'AEP';
    departureDate;
    returnDate;
    searchResult;

    get options() {
        return [
            { label: 'Montevideo', value: 'MVD'},
            { label: 'Panama', value: 'PTY'},
            { label: 'New York', value: 'JFK'},
            { label: 'Sao Pablo', value: 'GRU'},
            { label: 'Buenos Aires', value: 'AEP'},
        ];
    }

    handleChangeOrigin(event) {
        this.origin = event.target.value;
    }

    handleChangeDestination(event) {
        this.destination = event.target.value;
    }

    handleChangeDepDate(event){
        this.departureDate = event.target.value;
    }
   
    handleChangeRetDate(event){
        this.returnDate = event.target.value;
    }


    handleClickSearch(){

        if(this.origin === this.destination || this.departureDate === undefined || this.returnDate === undefined) return;
    
        getScale({origin: this.origin, destination: this.destination, travelDate: this.departureDate})
            .then(result => {
                this.searchResult = result;

                console.log(this.searchResult[0]);
            })
            .then(() => {

                const searchEvent = new CustomEvent("getsearchvalue", {
                    detail: this.searchResult[0]
                })
        
                this.dispatchEvent(searchEvent);
            })
            .catch(error => {
                console.log(error);
            })
    }
}