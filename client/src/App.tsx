import React from 'react';
import axios, { AxiosResponse } from 'axios';
import './App.css';

function App() {

    axios.get("/api/test")
        .then((response: AxiosResponse) => {
            console.log(response.data);
        })
        .catch(e => {
            console.log(e);
        });

    return (
        <div className="App">
            Hello World
        </div>
    );
}

export default App;
