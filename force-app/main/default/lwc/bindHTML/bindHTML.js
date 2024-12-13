import { LightningElement,track } from 'lwc';

export default class BindHTML extends LightningElement {

  //  @track myValue = {key:'test'};
    
  showMe = false;
  handleChange(event){
    this.showMe = event.target.checked;


   } 
}