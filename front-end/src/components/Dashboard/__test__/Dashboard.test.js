import React from "react";
import Dashboard from "../Dashboard";
import DashboardSplash from "../DashboardSplash";
import DashboardHeader from "../DashboardHeader";
import DashboardCTA from "../DashboardCTA";
import LearningPaths from "../../LearningPath/LearningPaths";
import { shallow } from "enzyme";
import MetaTags from "../../SEO/MetaTags";

describe("Dashboard", () => {

  it("should render meta tags with dashboard specific information", () => {
    const wrapper = shallow(<Dashboard />);
    expect(wrapper.find(MetaTags).exists()).toBe(true);

    const metaWrapper = wrapper.find(MetaTags).dive();
    expect(metaWrapper.find('title').text()).toBe("SBA Dashboard");
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe("Description for the dashboard");
    expect(metaWrapper.find("link[rel='canonical']").props().href).toBe("https://sba.gov/eli")
  });

  it("should render a <div>", () => {
    const wrapper = shallow(<Dashboard />);

    expect(wrapper.find("div").length).toEqual(1);
  });

  it("should render <LearningPaths>", () => {
    const wrapper = shallow(<Dashboard />);

    expect(wrapper.find(LearningPaths).length).toEqual(1);
  });
});


describe("Dashboard when user is logged in", () => {

  it("should render a DashboardHeader", () => {
    const wrapper = shallow(<Dashboard />);
    wrapper.setState({ isLoggedIn: true });

    const inst = wrapper.instance()
    const isLoggedIn = inst.state.isLoggedIn;

    expect(inst.dashboardHeader(isLoggedIn)).toEqual(<DashboardHeader />)
  });

  it("should render a Dashboard Call To Action", () => {
    const wrapper = shallow(<Dashboard />);
    wrapper.setState({ isLoggedIn: true });

    const inst = wrapper.instance()
    const isLoggedIn = inst.state.isLoggedIn;

    expect(inst.splash(isLoggedIn)).toEqual(<DashboardCTA />)
  });

  it("should not render a DashboardSlash", () => {
    const wrapper = shallow(<Dashboard />);
    wrapper.setState({ isLoggedIn: true});

    const inst = wrapper.instance()
    const isLoggedIn = inst.state.isLoggedIn;

    expect(inst.splash(isLoggedIn)).not.toEqual(<DashboardSplash />)
  });
});

describe("Dashboard when user is not logged in", () => {

  it("should render a DashboardSlash", () => {
    const wrapper = shallow(<Dashboard />);
    wrapper.setState({ isLoggedIn: false});

    const inst = wrapper.instance()
    const isLoggedIn = inst.state.isLoggedIn;

    expect(inst.splash(isLoggedIn)).toEqual(<DashboardSplash />)
  });

  it("should not render a Dashboard Call To Action", () => {
    const wrapper = shallow(<Dashboard />);
    wrapper.setState({ isLoggedIn: false});

    const inst = wrapper.instance()
    const isLoggedIn = inst.state.isLoggedIn;

    expect(inst.splash(isLoggedIn)).not.toEqual(<DashboardCTA />);
  });
});
