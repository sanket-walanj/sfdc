import { LightningElement, track } from 'lwc';
import getRandomCocktail from '@salesforce/apex/Cocktails.getRandomCocktail';
import getSearchedCocktails from '@salesforce/apex/Cocktails.getSearchedCocktails';
import getCocktailRecipe from '@salesforce/apex/Cocktails.getCocktailRecipe';

export default class Cocktails_home extends LightningElement {


    @track cocktails = [];
    fetchRandomRecipe() {
        getRandomCocktail()
        .then((data) => {
            console.log(data);
            console.log(JSON.parse(data));
            this.cocktails =
            JSON.parse(data) && JSON.parse(data).drinks
                ? JSON.parse(data).drinks
                : [];
            
            console.log('Cocktails', this.cocktails);
        })
        .catch((error) => {
            console.error(error);
        });
    }

    searchCocktails(e){
        let ingredient = e.target.value
        console.log('Search Called');
        console.log('searchText', ingredient);
        getSearchedCocktails({ingredient})
        .then((data) =>{
            console.log(data);
            console.log(JSON.parse(data));
            data = JSON.parse(data);
            this.cocktails = data.drinks;
            console.log('this.cocktails after search', this.cocktails)
        })
        .catch((error) => {
            console.error(error);
        });
    }




    async connectedCallback(){
        console.log('Connected Callback');

        await this.fetchRandomRecipe();
    }
}