var DeveloperTools = React.createClass({
	resetFingerprintClicked: function() {
		new Fingerprint2().get( function(result,components) {
			console.log( result );
			console.log( components );
			post('/developers/reset_fingerprint', {
        fingerprint: result,
        driverNumber: JSON.parse(localStorage.licenceData).licence.driverNumber,
        token: localStorage.token
      });
		});
	},

  resetTokenClicked: function() {
		new Fingerprint2().get( function(result,components) {
      localStorage.removeItem("token");
      window.location = "/webapps";
		});
	},

	componentDidMount: function(){
		document.getElementById("reset-fingerprint").onclick = this.resetFingerprintClicked;
		document.getElementById("reset-token").onclick = this.resetTokenClicked;
	},

	render: function() {
		return(
			<div className="component-wrapper">
				<div className="list-block">
					<ul>
						<li>
							<a href="#" id="reset-fingerprint" className="item-link list-button">
                Reset device fingerprint
              </a>
						</li>
					</ul>
				</div>
        <div className="list-block">
					<ul>
						<li>
							<a href="#" id="reset-token" className="item-link list-button">
                Clear auth token
              </a>
						</li>
					</ul>
				</div>
			</div>
		);
	}
});

// ReactDOM.render(
//  <Controls />,
//  document.getElementById('controls')
// );
