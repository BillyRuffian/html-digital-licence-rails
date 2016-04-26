var MediaListRow = React.createClass({
  render: function() {
    var image;
    if( this.props.mediaUrl != null ) {
      image = (<div className="item-media"><img src={this.props.mediaUrl} width="80" /></div>);
    }

    var text;
    if( this.props.text != null ) {
      text = <div className="item-text">{this.props.text}</div>
    }

    return (

      <li>
        <div className="item-content">
          {image}
          <div className="item-inner">
            <div className="item-title-row">
              <div className="item-title">{this.props.item}</div>
            </div>
            <div className="item-subtitle">{this.props.subtitle}</div>
            {text}
          </div>
        </div>
      </li>
    );
  }
});


var Licence = React.createClass({

  getInitialState: function() {
    return {
      licence: {
        name: 'Mr Foo Bar Tron',
        photoUrl: 'img/photo.png',
        dateOfBirth: '01.01.1971',
        dateOfIssue: '02.02.1990',
        dateOfExpiry: '03.03.2030'
      },
      status: {
        doneLoading: false
      }
    }
  },

  componentDidMount: function() {
    console.log('licence data update request');
    $.ajax({
      url: 'api/data.json',
      dataType: 'json',
      cache: false,
      success: function(data) {
        console.log('licence data received from remote');
        this.setState({
          licence: data.licence,
          status: {
            doneLoading: true
          }
        });
        localStorage.licenceData = JSON.stringify(data);
        localStorage.cachedAt = moment().format('lll');
        console.log('licence data persisted to local storage');
      }.bind(this),
      error: function(xhr, status, err) {
        console.log('licence data could not be retrieved from remote');
        var licence = JSON.parse(localStorage.licenceData);
        if(licence != null) {
          this.setState( {licence: licence.licence} );
          console.log("licence data retrieved from local storage");
          myApp.addNotification({
            title: 'DVLA Digital Licence',
            subtitle: 'Cached Copy',
            message: 'Unable to connect to the network, using licence data cached ' + localStorage.cachedAt
          });
        }

        this.setState({ status:{doneLoading:true} });

        console.error(status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    if( this.state.status.doneLoading ) {
      return (
        <div className="component-wrapper">

          <Licence.PersonalDetails licence={this.state.licence} />
          <Licence.Entitlements entitlements={this.state.licence.entitlements} />
          <Licence.Endorsements endorsements={this.state.licence.endorsements} />

        </div>
      );
    } else {
      return (
        <div className="component-wrapper">
          <div className="content-block center">
            <span className="preloader preloader-large"></span>
          </div>
        </div>
      );
    }
  }
});


Licence.PersonalDetails = React.createClass({
  render: function() {
    return(
        <div className="component-wrapper">
          <div className="content-block-title">Personal Details</div>
          <div className="list-block media-list">
            <ul>
              <MediaListRow
                mediaUrl={this.props.licence.photoUrl}
                item={this.props.licence.name}
                subtitle={this.props.licence.driverNumber}
								text={this.props.licence.address}
              />
              <MediaListRow item={this.props.licence.dateOfBirth} subtitle='Date of Birth' />
              <MediaListRow item={this.props.licence.dateOfIssue} subtitle='Licence Issue Date' />
              <MediaListRow item={this.props.licence.dateOfExpiry} subtitle='Licence Expiry Date' />
            </ul>
          </div>

        </div>

    );
  }
});

Licence.Endorsements = React.createClass({
  render: function() {
    var endorsements = this.props.endorsements.map(function(e) {
      return <Licence.Endorsements.Endorsement
        endorsement={e}
        key={e.code + e.dateOfEndorsement}
      />
    });

    var totalPoints = this.props.endorsements.reduce( function( points, e ) {
      return points + e.points;
    }, 0 );

    return(
      <div className="component-wrapper">
        <div className="content-block-title">Endorsements - {totalPoints} Points</div>
        <div className="list-block media-list">
          <ul>
            {endorsements}
          </ul>
        </div>
      </div>
    );
  }
});



Licence.Entitlements = React.createClass({
  render: function() {
    var entitlements = this.props.entitlements.map(function(e) {
      return <Licence.Entitlements.Entitlement
        entitlement={e}
        key={e.category}
      />
    });

    return(
      <div className="component-wrapper">
        <div className="content-block-title">Entitlements</div>
        <div className="list-block media-list">
          <ul>
            {entitlements}
          </ul>
        </div>
      </div>
    );
  }
});

Licence.Endorsements.Endorsement = React.createClass({
  render: function() {

    var formattedDate = moment(this.props.endorsement.dateOfEndorsement).format('LL');

    return (
      <MediaListRow
        item={'Code ' + this.props.endorsement.code}
        subtitle={'Points ' + this.props.endorsement.points}
        text={formattedDate}
      />
    );
  }
});

Licence.Entitlements.Entitlement = React.createClass({
  render: function() {
    return (
      <MediaListRow
        item={'Category ' + this.props.entitlement.category}
        subtitle={this.props.entitlement.provisional ? 'Provisional' : 'Full'}
        text={this.props.entitlement.description}
      />
    );
  }
});

//ReactDOM.render(
//  <Licence />,
//  document.getElementById('licence')
//);
