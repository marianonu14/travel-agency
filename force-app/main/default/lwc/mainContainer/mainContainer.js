import { LightningElement, track } from 'lwc';

export default class MainContainer extends LightningElement {
    @track searchValue;
    
    handleSearchValue(event){
        this.searchValue = event.detail;
    }
}