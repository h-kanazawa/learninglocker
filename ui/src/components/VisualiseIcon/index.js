/* eslint-disable react/jsx-indent */
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import classNames from 'classnames';
import styles from './visualiseicon.css';
import {
  LEADERBOARD,
  PLATFORMS,
  QUESTIONANALYSIS,
  XVSY,
  SESSIONS,
  STATEMENTS,
  FREQUENCY,
  COUNTER,
  PIE,
  TABLE
} from '../../utils/constants';
import {
  COUNTER_IMAGE,
  FREQUENCY_IMAGE,
  LEADERBOARD_IMAGE,
  PIE_IMAGE,
  SESSIONS_IMAGE,
  STATEMENTS_IMAGE,
  TABLE_IMAGE,
  XVSY_IMAGE,
} from './assets';

const PLATFORMS_IMAGE = SESSIONS_IMAGE;
const QUESTIONANALYSIS_IMAGE = SESSIONS_IMAGE;

class VisualiseIcon extends Component {
  static propTypes = {
    type: PropTypes.string,
    active: PropTypes.bool,
    onClick: PropTypes.func,
    isSmall: PropTypes.bool,
  }

  static defaultProps = {
    active: false,
    onClick: () => null,
    isSmall: false,
  }

  getTitle = (type) => {
    switch (type) {
      case LEADERBOARD: return 'Bar';
      case XVSY: return 'Correlation';
      case STATEMENTS: return 'Column';
      case FREQUENCY: return 'Line';
      case COUNTER: return 'Counter';
      case PIE: return 'Pie';
      case SESSIONS: return 'Sessions';
      case PLATFORMS: return 'Platforms';
      case QUESTIONANALYSIS: return 'Question analysis';
      default: return '';
    }
  }

  getIcon = (type, sourceView) => {
    if (sourceView) {
      return TABLE_IMAGE;
    }
    switch (type) {
      case LEADERBOARD: return LEADERBOARD_IMAGE;
      case XVSY: return XVSY_IMAGE;
      case STATEMENTS: return STATEMENTS_IMAGE;
      case FREQUENCY: return FREQUENCY_IMAGE;
      case COUNTER: return COUNTER_IMAGE;
      case PIE: return PIE_IMAGE;
      case SESSIONS: return SESSIONS_IMAGE;
      case PLATFORMS: return PLATFORMS_IMAGE;
      case TABLE: return TABLE_IMAGE;
      case QUESTIONANALYSIS: return QUESTIONANALYSIS_IMAGE;
      default: return '';
    }
  }

  renderIcon = ({ className } = {}) => {
    const { type, sourceView } = this.props;
    return (
      <img
        className={styles[className]}
        src={this.getIcon(type, sourceView)}
        alt={this.getTitle(type)} />
    );
  }

  // return type !== 'undefined' ? (
  //   <img
  //     className={styles[className]}
  //     src={this.getIcon(type)}
  //     alt={this.getTitle(type)} />
  // ) : <img
  //   className={styles.visualisationSmall}
  //   src={this.getIcon(SESSIONS)}
  //   alt={this.getTitle(SESSIONS)} />;

  render = () => {
    const { type, active, onClick, isSmall, className } = this.props;
    const classes = classNames({
      [styles['visualisation-icon']]: true,
      [styles.active]: active
    });

    return (
      isSmall
      ? this.renderIcon({ className })
      : (
        <div className={classes} onClick={onClick} >
          { this.renderIcon() }
          <h5>{this.getTitle(type)}</h5>
        </div>
      )
    );
  }
}

export default withStyles(styles)(VisualiseIcon);
