var QRCodeButton = React.createClass({


	render: function() {
		return(
			<div className="component-wrapper">
				<div className="list-block">
					<ul>
						<li>
							<a href="/qrcodes" id="generate-qr-code" className="item-link list-button">Generate QR Code</a>
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
