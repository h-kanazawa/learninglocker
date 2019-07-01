import React from 'react';
import { compose } from 'recompose';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import styles from './styles.css';
import InputFields from './InputFields';

export const ColumnHeaderEditor = ({
  model, // personasImports model
  disabled
}) => (
  <table className={styles.table}>
    <thead>
      <tr className={styles.tr}>
        <th className={styles.th}>ID Names</th>
        <th className={styles.th}>Input Fields</th>
      </tr>
    </thead>

    <tbody>
      {
        model
          .get('structure', new Map())
          .map((columnStructure, columnName) => (
            <tr key={columnName} className={styles.tr}>
              <td className={styles.td}>
                {columnName}
              </td>

              <InputFields
                columnStructure={columnStructure}
                model={model}
                disabled={disabled} />
            </tr>
          )).toList().toJS()
      }
    </tbody>
  </table>
);

export default compose(
  withStyles(styles)
)(ColumnHeaderEditor);
