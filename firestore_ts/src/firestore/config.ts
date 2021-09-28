import firebase from 'firebase/app';
import 'firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyDuooGO4tJg6CxkLU3MZjJJueC2s_8k7ko",
  authDomain: "sql-demos-19547.firebaseapp.com",
  projectId: "sql-demos-19547",
  storageBucket: "sql-demos-19547.appspot.com",
  messagingSenderId: "559793092736",
  appId: "1:559793092736:web:59ea4e41c10031da3e4e65",
  measurementId: "G-7CMCSBTXB1"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

export default firebase.firestore();