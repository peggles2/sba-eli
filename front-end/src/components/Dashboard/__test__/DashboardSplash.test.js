import React from "react";
import DashboardSplash from "../DashboardSplash";
import { Grid } from "semantic-ui-react";
import { shallow } from "enzyme";

describe("DashboardSplash", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<DashboardSplash.WrappedComponent />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <Grid>", () => {
    const wrapper = shallow(<DashboardSplash.WrappedComponent />);

    expect(wrapper.find(Grid).length).toEqual(1);
  });
});
