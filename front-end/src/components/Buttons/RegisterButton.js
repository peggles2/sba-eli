import React from "react";
import { Button } from "semantic-ui-react";

import { connect } from "react-redux";
import { toggleRegister } from "../../actions/navbarActions";

export const RegisterButton = (props) => {
  return (
    <Button primary onClick={() => props.toggleRegister(true)}>
      Register
    </Button>
  );
};

const mapStateToProps = store => {
  return {
    modalType: store.navbar.modalType,
    open: store.navbar.open,
  }
};

const mapDispatchToProps = dispatch => {
  return {
    toggleRegister: (show) => { dispatch(toggleRegister(show)) },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(RegisterButton);
