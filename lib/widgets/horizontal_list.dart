import 'package:flutter/material.dart';
 
// ignore: must_be_immutable
class HorizontalListBuilder<T> extends StatefulWidget {
  Future future;
  bool fromFuture;
  List<T> data;
  Function(T x) child;
  Widget errWidget;
  Widget loadingWidget;

  HorizontalListBuilder.fromFuture(
      {Key key,
      this.future,
      this.fromFuture = true,
      this.child,
      this.errWidget,
      this.loadingWidget})
      : super(key: key);
  HorizontalListBuilder.fromData(
      {Key key,
      this.data,
      this.fromFuture = false,
      this.child,
      this.errWidget,
      this.loadingWidget})
      : super(key: key);

  @override
  _HorizontalListBuilderState<T> createState() =>
      _HorizontalListBuilderState<T>();
}

class _HorizontalListBuilderState<T> extends State<HorizontalListBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.fromFuture == true
        ? FutureBuilder<List<T>>(
            future: widget.future,
            builder: (context, snap) {
              print(snap.connectionState);
              print(snap.data);

              if (snap.connectionState == ConnectionState.waiting ||
                  snap.connectionState == ConnectionState.active) {
                return widget.loadingWidget;
              }
              if (snap.hasError) {
                return widget.errWidget;
              }
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return widget.child(snap.data[index]);
                },
              );
            },
          )
        :  ListView.builder(
              shrinkWrap: true,scrollDirection: Axis.horizontal,
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return widget.child(widget.data[index]);
                },
              );
            
  }
}
