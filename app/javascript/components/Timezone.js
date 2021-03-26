import React from "react"
import PropTypes from "prop-types"
class Timezone extends React.Component {

  constructor(props) {
    super(props);
    this.state = {value: this.props.user.timezone}

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    event.preventDefault();
    const token = document.querySelector('[name=csrf-token]').content
    $.ajax({
      method: 'PATCH',
      data: JSON.stringify({timezone: this.state.value}),
      url: `/clock/${this.props.user.id}/`,
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      credentials: 'same-origin'
    })
  }

  render () {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <label className="form-label w-100">
            <h3>Select your timezone:</h3>
            <select className="form-control mt-3" value={this.state.value} onChange={this.handleChange}>
              {this.props.timezones.map((timezone, index) => {
                return <option key={index} value={timezone.name}>{timezone.name}</option>
                })
              }
            </select>
          </label><br></br>
          <input type="submit" value="Save timezone" className="btn btn-primary mt-3" />
        </form>
      </div>
    );
  }
}

Timezone.propTypes = {
  timezones: PropTypes.array
};
export default Timezone
