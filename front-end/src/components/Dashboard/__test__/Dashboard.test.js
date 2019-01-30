import React from "react";
import { Dashboard } from "../Dashboard";
import DashboardSplash from "../DashboardSplash";
import DashboardHeader from "../DashboardHeader";
import DashboardCTA from "../DashboardCTA";
import LearningPaths from "../../LearningPath/LearningPaths";
import { shallow } from "enzyme";
import { Helmet } from "react-helmet";
import MetaTags from "../../SEO/MetaTags";

describe("Dashboard", () => {
  it("should render meta tags with dashboard specific information", () => {
    const wrapper = shallow(<Dashboard />);
    expect(wrapper.find(MetaTags).exists()).toBe(true);

    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe("SBA Dashboard");
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe("Description for the dashboard");
    expect(helmetProps.link[0].rel).toBe("canonical");
    expect(helmetProps.link[0].href).toBe("https://sba.gov/eli");
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
    const wrapper = shallow(<Dashboard isUserLoggedIn={true} />);

    expect(wrapper.find(DashboardHeader).exists()).toBe(true);
  });

  it("should render a Dashboard Call To Action", () => {
    const wrapper = shallow(<Dashboard isUserLoggedIn={true} />);

    expect(wrapper.find(DashboardCTA).exists()).toBe(true);
  });

  it("should not render a DashboardSplash", () => {
    const wrapper = shallow(<Dashboard isUserLoggedIn={true} />);

    expect(wrapper.find(DashboardSplash).exists()).toBe(false);
  });
});

describe("Dashboard when user is not logged in", () => {
  it("should render a DashboardSplash", () => {
    const wrapper = shallow(<Dashboard isUserLoggedIn={false} />);

    expect(wrapper.find(DashboardSplash).exists()).toBe(true);
  });

  it("should not render a Dashboard Call To Action", () => {
    const wrapper = shallow(<Dashboard isUserLoggedIn={false} />);

    expect(wrapper.find(DashboardCTA).exists()).toBe(false);
  });
});
