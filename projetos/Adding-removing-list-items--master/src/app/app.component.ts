import { Component } from '@angular/core';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent {
    items = ["Angular 4", "JavaScript", "React"];
    newItem = "";
    //Pushing the new item in items array
    pushItem = function() {
        if(this.newItem != "") {
            this.items.push(this.newItem);
            this.newItem = ""; //clear the text feild after adding item
        }
    }

    //Removing the item in items array
    removeItem = function(index) {
        this.items.splice(index, 1);
    }
}
