import React, { Component } from "react";
import ReactPlayer from "react-player";
import { Button, Icon } from "semantic-ui-react";
import { findDOMNode } from "react-dom";
import Duration from "./LearningEventVideo/Duration";
import screenfull from "screenfull";
import "./Slider.scss";
import "./PlayerControls.scss";
import { withRouter } from "react-router-dom";
import { connect } from "react-redux";
import { completeLearningEvent } from "../../actions/learningEventActions";

export class LearningEventVideo extends Component {
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
    height: "100%",
    width: "100%"
  };

  playPause = () => {
    this.setState({ playing: !this.state.playing });
  };

  setVolume = e => {
    this.setState({ volume: parseFloat(e.target.value) });
  };

  toggleMuted = () => {
    this.setState({ muted: !this.state.muted });
  };

  onSeekMouseDown = e => {
    this.setState({ seeking: true });
  };

  onSeekChange = e => {
    this.setState({ played: parseFloat(e.target.value) });
  };

  onSeekMouseUp = e => {
    this.setState({ seeking: false });
    this.player.seekTo(parseFloat(e.target.value));
  };

  onProgress = state => {
    if (!this.state.seeking) {
      this.setState(state);
    }
  };

  onDuration = duration => {
    this.setState({ duration });
  };

  onClickFullscreen = () => {
    screenfull.request(findDOMNode(this.player));
  };

  onEnded = () => {
    const { event, isUserLoggedIn, match } = this.props;

    if (isUserLoggedIn && !event.completion_requirement.completed) {
      const { id: path_id, topicId: objective_id } = match.params;

      this.props.dispatch(
        completeLearningEvent(path_id, objective_id, event.id)
      );
    }
  };

  ref = player => {
    this.player = player;
  };

  render() {
    const {
      url,
      playing,
      volume,
      muted,
      pip,
      played,
      duration,
      playbackRate,
      loop,
      height,
      width
    } = this.state;

    return (
      <div>
        <div className="player-wrapper">
          <ReactPlayer
            ref={this.ref}
            url={url}
            pip={pip}
            playing={playing}
            loop={loop}
            playbackRate={playbackRate}
            volume={volume}
            muted={muted}
            height={height}
            width={width}
            onProgress={this.onProgress}
            onDuration={this.onDuration}
            onEnded={this.onEnded}
          />
        </div>
        <div className="player-controls" style={{ width: width }}>
          <Button.Group basic color="black" icon>
            <Button onClick={this.playPause} aria-label="play">
              {playing ? (
                <Icon name="pause" size="large" inverted color="grey" />
              ) : (
                <Icon name="play" size="large" inverted color="grey" />
              )}
            </Button>
            <Button icon basic onClick={this.toggleMuted} aria-label="mute">
              {muted ? (
                <Icon name="volume off" size="big" inverted color="grey" />
              ) : (
                <Icon name="volume up" size="big" inverted color="grey" />
              )}
            </Button>
          </Button.Group>
          <input
            type="range"
            min={0}
            max={1}
            step="any"
            value={volume}
            onChange={this.setVolume}
            className="volumeSlider"
          />
          <span className="seek-bar" style={{ marginTop: "15px" }}>
            <input
              type="range"
              min={0}
              max={1}
              step="any"
              value={played}
              onMouseDown={this.onSeekMouseDown}
              onChange={this.onSeekChange}
              onMouseUp={this.onSeekMouseUp}
              className="slider"
            />
            <span className="duration">
              <b>
                <Duration seconds={duration * played} />
              </b>{" "}
              / <Duration seconds={duration} />
            </span>
          </span>
          <Button.Group basic icon color="black" floated="right">
            <Button aria-label="closed captioning">
              <Icon name="closed captioning" size="big" color="orange" />
            </Button>
            <Button onClick={this.onClickFullscreen} aria-label="fullscreen">
              <Icon name="expand" size="big" inverted color="grey" />
            </Button>
          </Button.Group>
        </div>
      </div>
    );
  }
}

const mapStateToProps = store => {
  return { isUserLoggedIn: store.login.isUserLoggedIn };
};

export default withRouter(connect(mapStateToProps)(LearningEventVideo));
