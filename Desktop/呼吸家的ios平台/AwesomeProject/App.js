/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet,ScrollView, Text, View,Image,AppRegistry,TextInput,Button,Alert,TouchableHighlight,TouchableOpacity,TouchableNativeFeedback,TouchableWithoutFeedback
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});



class Blink extends Component{
  constructor(pros){
    super(pros);
    this.state = {isShowingText:true};
    
    setInterval(()=>{
      this.setState(previousState=>{
       return {isShowingText:!previousState.isShowingText};
       });
    },1000);
  }
  render(){
   if (!this.state.isShowingText) {return null;}
   return (
     <Text>{this.props.text}</Text>
   
    );
   }
}

type Props = {};
export default class App extends Component<Props> {
   constructor(props) {
    super(props);
    this.state = {text: '111'};
  }
   _pressButton(){
    Alert.alert('You tapped the button')
   }
  render() {

    let pic = {
        uri:'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
      };
    return (


      <View style={{width:150,height:200},styles.container}>

<ScrollView>
<Text style={{fontSize:96}}>ScrollView</Text>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Text style={{fontSize:96}}>if you like this</Text>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>
<Image source={{uri:"https://facebook.github.io/react-native/img/favicon.png",width:64,height:64}}/>

</ScrollView>


      </View>
      
        /*  <View style={styles.button}>
            <Text style={styles.buttonText}>TouchableHighlight</Text>
          </View>


     <View style={styles.buttonContainer}>
        <Button onpress={this._pressButton } title="点我" />
     </View>
         <View style={{
       backgroundColor: this.state.text,
       borderBottomColor: '#000000',
       borderBottomWidth: 1 ,width:150,height:200}}
     >
       <TextInput
         multiline = {true}
         numberOfLines = {4}
         onChangeText={(text) => this.setState({text})}
         value={this.state.text}
       />
     </View>
        <Text style={styles.welcome}>just red!</Text>
        <Text style={styles.instructions,styles.bigBlue}> edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
         <Image source={pic} style={{width: 193, height: 110}} />
        <Blink text='I love to blink' />
        <Blink text='Yes blinking is so great' />
        <Blink text='Why did they ever take this out of HTML' />
        <Blink text='Look at me look at me look at me' />


     <View style={{padding:10,fontSize:30}}>
     <TextInput style={{height:40,width:200}} placeholder="please write here" onChangeText= {(text)=>this.setState({text})}/>
     <Text style={{padding:10,fontSize:42}}>
     {this.state.text.split('').map((word)=>word&&'@').join(' ')}
     </Text>
     <TextInput style = {{height:40,borderColor:'gray',borderWidth:1,width:200,justifyContent:'center',alignItems:'center'}} onChangeText={(text)=>this.setState({text})} value={this.state.text}/>
       </View>
     */

    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,/*某个组件扩张以撑满所有剩余的空间*/
    flexDirection: 'column',/*主轴*/
    justifyContent: 'center',/*决定其子元素沿着主轴的排列方式.主轴的起始端还是末尾段分布 flex-start flex-end space-around space-between space-evently*/
    alignItems: 'center',/*子元素沿着次轴的排列方式 flex-start、center、flex-end以及stretch*/
    backgroundColor: '#F1FCFF',
  },
  bigBlue:{
    color:'blue',
    fontWeight:'bold',
    fontSize: 30,
    
  },
  buttonContainer:{
    margin:20
  },
  welcome: {
    
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
    
  },
   button: {
    marginBottom: 30,
    width: 260,
    alignItems: 'center',
    backgroundColor: '#2196F3',
  },
  buttonText: {
    padding: 20,
    color: 'white',
  },
});
