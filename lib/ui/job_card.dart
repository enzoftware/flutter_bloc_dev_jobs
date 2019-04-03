import 'package:dev_jobs_bloc/domain/model/models.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final JobEntity jobEntity;

  JobCard({Key key, this.jobEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: 200,
          width: double.maxFinite,
          margin: EdgeInsets.fromLTRB(14, 18, 12, 16),
          padding: EdgeInsets.fromLTRB(16, 85, 16, 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.card_travel, color: Colors.blueGrey,),
                  Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(jobEntity.company),)
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.place, color: Colors.blueGrey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(jobEntity.location),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(jobEntity.type, style: TextStyle(
                        color: jobEntity.type.contains("Full")
                            ? Colors.green
                            : Colors
                            .red
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildIcon(),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Text(jobEntity.title, style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 85,
      height: 85,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 6, top: 0, right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 1
            )
          ]
      ),
      child: Image.network(jobEntity.companyLogo, width: 80, height: 80,),
    );
  }
}
