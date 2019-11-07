/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React from 'react';
import {
  StyleSheet,
  View,
  Text,
} from 'react-native';

import Dimension from 'react-native-pure-dimension'

const App = () => {
  return (
    <View style={styles.container}>
      <Text
        style={styles.button}
        onPress={() => {
          Dimension.getStatusBarHeight()
          .then(data => {
            console.log(data)
          })
        }}
      >
        getStatusBarHeight
      </Text>
      <Text
        style={styles.button}
        onPress={() => {
          Dimension.getNavigationBarInfo()
            .then(data => {
              console.log(data)
            })
        }}
      >
        getNavigationBarInfo
      </Text>
      <Text
        style={styles.button}
        onPress={() => {
          Dimension.getScreenSize()
            .then(data => {
              console.log(data)
            })
        }}
      >
        getScreenSize
      </Text>
      <Text
        style={styles.button}
        onPress={() => {
          Dimension.getSafeArea()
            .then(data => {
              console.log(data)
            })
        }}
      >
        getSafeArea
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: 20
  },
  button: {
    margin: 20,
    padding: 10
  }
});

export default App;
