import React from 'react';
import { compose } from 'recompose';
import DebounceInput from 'react-debounce-input';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import { getAccountHomePageColumns } from 'lib/services/importPersonas/personasImportHelpers';
import Switch from 'ui/components/Material/Switch';
import styles from './styles.css';

/**
 * @param {boolean} _.disabled
 * @param {immutable.Map} _.structure
 * @param {string} _.relatedColumn
 * @param {boolean} _.useConstant
 * @param {string} _.constant
 * @param {(column: string) => void} _.onRelatedColumnChange
 * @param {(useConstant: boolean) => void} _.onUseConstantChange
 * @param {(constant: string) => void} _.onConstantChange
 */
const AccountHomePageForm = ({
  disabled,
  structure,
  relatedColumn,
  useConstant,
  constant,
  onRelatedColumnChange,
  onUseConstantChange,
  onConstantChange,
}) => {
  const options = getAccountHomePageColumns(structure).map(column => (
    <option key={column} value={column}>
      {column}
    </option>
  ));

  return (
    <div className={`form-group ${styles.inputField}`}>
      <label>
        Account home page
      </label>

      <Switch
        label="Select column"
        checked={!useConstant}
        onChange={checked => onUseConstantChange(!checked)}
        disabled={disabled} />

      <Switch
        label="Set value"
        checked={useConstant}
        onChange={checked => onUseConstantChange(checked)}
        disabled={disabled} />

      {!useConstant && (
        <select
          className="form-control"
          onChange={onRelatedColumnChange}
          value={relatedColumn}
          disabled={disabled}>
          <option disabled />
          {options}
        </select>
      )}

      {useConstant && (
        <DebounceInput
          className="form-control"
          debounceTimeout={377}
          value={constant}
          onChange={e => onConstantChange(e.target.value)}
          disabled={disabled}
          placeholder="https://example.com" />
      )}
    </div>
  );
};

export default compose(
  withStyles(styles)
)(AccountHomePageForm);
