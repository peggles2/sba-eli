import React, {Component} from "react";
import ReactPlayer from "react-player";

export default class LearningEventPodcast extends Component {
  state = {
    url: this.props.url,
    playing: false,
    volume: 0.8,
    muted: false,
    pip: false,
    played: 0,
    loaded: 0,
    duration: 0,
    playbbackRate: 1.0,
    loop: false,
    height: '100%',
    width: '100%'
  }

  render() {
    return (
      <div>
        This is a podcast.
      </div>
    )
  }
}
