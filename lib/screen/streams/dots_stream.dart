

import 'dart:async';

import 'package:fluttershop/contracts/contracts.dart';

class DoteStream implements Disposble{
  int currentDot;
  StreamController<int> _dotsStreamController = StreamController<int>.broadcast();
  Stream<int> get Dots => _dotsStreamController.stream;
  StreamSink<int> get dotsSink => _dotsStreamController.sink;

  DoteStream(){
    _dotsStreamController.add(currentDot);
    _dotsStreamController.stream.listen(_indexChange);
  }

  void _indexChange(int newIndex){
   currentDot = newIndex;
   _dotsStreamController.add(currentDot);
  }

  @override
  void dispose() {
    _dotsStreamController.close();
  }
}